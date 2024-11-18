create or replace FUNCTION FUNTION_GET_TARGET_DATE (
  /*
  ����(Now) ��¥���� ��,���� ���� �Ǵ� ���� �Ͽ� ��¥�� ���ϴ� ���� �Լ�
  ��, ������ �����Ͽ��� ���ڴ� ���� �߰����� ����
  ������� ���������� ��ȯ
  ������ FUNTION_GET_TARGET_DATE('(���糯¥)', (������ ��), (������ ��), (������ ��))
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
    --1�� �������� �⵵ ����ǹǷ� �߰��� �⵵�� ����
    nMonth_Temp := -1 * (nDate_Month + nMonth_cnt);   

    if nMonth_Temp >= 0 then
      nYear_Temp := -1 * (TRUNC(nMonth_Temp / 12) + 1);
    end if;

    --2���� ���߱� ���� 12�� ���� ������ ����
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

  --1~9���� ���ڸ� ���ڷ� ����
  if nMonth < 10 then  --1~9 �� �ǹǷ� �տ� '0'�� �ٿ��� �ζ��� ���ڷ� ����
    sMonth := '0' || to_char(nMonth);
  elsif nMonth >= 10 then
    sMonth := to_char(nMonth);
  end if;

  sYear := to_char(nDate_Year + nYear_cnt + nYear_Temp);

  return sYear || sMonth || '31';

END;