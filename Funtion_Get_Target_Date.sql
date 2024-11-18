create or replace FUNCTION FUNTION_GET_TARGET_DATE (
  /*
  현재(Now) 날짜에서 년,월을 차감 또는 증가 하여 날짜를 구하는 쿼리 함수
  년, 월까지 구현하였고 일자는 아직 추가하지 않음
  결과값은 문자형으로 반환
  사용법은 FUNTION_GET_TARGET_DATE('(현재날짜)', (증차감 년), (증차감 월), (증차감 일))
  */
  sDate varchar2,
  nYear_cnt number,
  nMonth_cnt number,
  nDay_cnt number
)
RETURN varchar2
IS  
  sDate_Year varchar2(4) := '';
  sDate_Month varchar2(2) := '';
  sDate_Day varchar2(2) := '';

  sYear varchar2(4) := '';
  sMonth varchar2(2) := '';
  sDay varchar2(2) := '';

  sYear_Temp varchar2(4) := '';
  sMonth_Temp varchar2(2) := '';
  sDay_Temp varchar2(2) := '';

  nDate_Year number(4) := 0;
  nDate_Month number := 0;
  nDate_Day number := 0;

  nYear number(4) := 0;
  nMonth number := 0;
  nDay number := 0;

  nYear_Temp number(4) := 0;
  nMonth_Temp number := 0;
  nDay_Temp number := 0;

  --nMaxDay number(2) := 0;
BEGIN
  sDate_Year := SubStr(sDate, 1, 4);
  sDate_Month := SubStr(sDate, 5, 2);
  sDate_Day := SubStr(sDate, 7, 2);

  nDate_Year := to_number(sDate_Year);
  nDate_Month := to_number(sDate_Month);
  nDate_Day := to_number(sDate_Day);


  if nMonth_cnt > 0 then  
    nMonth := mod(nDate_Month + nMonth_cnt, 12);

    nYear_Temp := TRUNC((nDate_Month + nMonth_cnt) / 12);    

    if (nYear_Temp = 1) and (nMonth = 0) then
      nYear_Temp := 0;
    end if;

  elsif nMonth_cnt < 0 then
    --1월 이전으로 년도 변경되므로 추가할 년도를 구함
    nMonth_Temp := -1 * (nDate_Month + nMonth_cnt);   

    if nMonth_Temp >= 0 then
      nYear_Temp := -1 * (TRUNC(nMonth_Temp / 12) + 1);
    end if;

    --2개월 맞추기 위해 12로 나눠 나머지 구함
    nMonth_Temp := MOD(-1*(nMonth_cnt), 12);

    if nMonth_Temp <> 0 then
      if (12 + nDate_Month - nMonth_Temp) <> 12 then
        nMonth := MOD(12 + nDate_Month - nMonth_Temp, 12);
      elsif (12 + nDate_Month - nMonth_Temp) = 12 then
        nMonth := 12 + nDate_Month - nMonth_Temp;
      end if;
    end if; 

  elsif nMonth_cnt = 0 then
    nMonth := nDate_Month;
  end if;

  --1~9월달 두자리 문자로 변경
  if nMonth < 10 then  --1~9 가 되므로 앞에 '0'을 붙여서 두라지 문자로 변경
    sMonth := '0' || to_char(nMonth);
  elsif nMonth >= 10 then
    sMonth := to_char(nMonth);
  end if;

  sYear := to_char(nDate_Year + nYear_cnt + nYear_Temp);

  return sYear || sMonth || '31';

END;