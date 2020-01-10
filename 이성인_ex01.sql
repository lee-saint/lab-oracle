/*
1. 
dbms_random.value() 함수 이용해서, 주사위 2개를 던졌을 때 나오는 눈을 (x, y) 형식으로 출력하는 PL/SQL을 작성하세요. 주사위 2개의 눈이 같아졌을 때 출력을 멈추세요.
(결과 예시)
1차: (1, 4)
2차: (5, 2)
3차: (6, 6)
*/
declare
    a number;       -- 주사위 눈의 값을 저장할 변수 두 개
    b number;
    cnt number := 0;     -- 몇번째 굴림인지를 저장하는 카운터
begin
    loop
        cnt := cnt + 1;                          -- 카운터에 1 추가
        a := trunc(dbms_random.value(1, 7));     -- 1 ~ 6 사이의 값을 난수로 저장
        b := trunc(dbms_random.value(1, 7));
        dbms_output.put_line(cnt || '차: (' || a || ', ' || b || ')');   -- 주사위 굴림 결과 출력
        exit when a = b;
    end loop;
end;
/