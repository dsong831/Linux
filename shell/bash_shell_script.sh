#!/bin/bash

# 특정 디렉토리 경로 찾기
find ./dir -maxdepth 7 -name "build*" -type d

# 디렉토리 링크 걸기 : ln -s <링크 할 디렉토리 주소> <링크 심볼 이름>
ln -s /mnt/c/work work

# 디렉토리 삭제 (하위 폴더 포함)
rm -rf work

# 슈퍼유저 권한 변경
sudo su

# 파일 내용 찾기 : grep <option> <pattern> <file>
# <option> : -r(하위폴더) / -w(단어단위) / -Hn(파일명,라인수)
# <pattern> : "^C"("C"로 시작하는 라인 검색) / "\.$"("."으로 끝나는 라인 검색)
grep -r -w -Hn "STR" *.txt

# 파일 내용 비교
gvimdiff ./a.txt ./b.txt
