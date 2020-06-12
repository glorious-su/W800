#!/bin/sh
ProjName="w800"
signature=0
prikey_sel=0
code_encrypt=0
sign_pubkey_src=0
img_type=1
zip_type=1
echo $ProjName
if [ $prikey_sel -gt 0 ]
 then
  let img_type=$img_type+32*$prikey_sel
fi

if [ $code_encrypt -eq 1 ]
 then
  let img_type=$img_type+16
fi

if [ $signature -eq 1 ]
 then
  let img_type=$img_type+256
fi

if [ $sign_pubkey_src -eq 1 ]
 then
  let img_type=$img_type+512
fi

echo $img_type

csky-elfabiv2-objcopy -O binary ./"$ProjName".elf ./"$ProjName".bin

if [ $code_encrypt -eq 1 ]
 then
  let prikey_sel=$prikey_sel+1
  openssl enc -aes-128-ecb -in ./"$ProjName".bin -out ./"$ProjName"_enc.bin -K 30313233343536373839616263646566 -iv 01010101010101010101010101010101
  openssl rsautl -encrypt -in ../../../../../tools/w800/ca/key.txt -inkey ../../../../../tools/w800/ca/capub_"$prikey_sel".pem -pubin -out key_en.dat
  cat "$ProjName"_enc.bin key_en.dat > "$ProjName"_enc_key.bin
  cat "$ProjName"_enc_key.bin ../../../../../tools/w800/ca/capub_"$prikey_sel"_N.dat > "$ProjName"_enc_key_N.bin  
  ../../../../../../../tools/w800/wm_tool.exe -b ./"$ProjName"_enc_key_N.bin -o ./"$ProjName" -it $img_type -fc 0 -ra 080d0400 -ih 080d0000 -ua 08010000 -nh 0  -un 0
 else
  ../../../../../../../tools/w800/wm_tool.exe -b ./"$ProjName".bin -o ./"$ProjName" -it $img_type -fc 0 -ra 080d0400 -ih 080d0000 -ua 08010000 -nh 0  -un 0
fi

mkdir -p ../../../../../../../bin/w800
mv ./"$ProjName".map ../../../../../../../bin/w800/"$ProjName".map

if [ $signature -eq 1 ]
 then
  openssl dgst -sign  ../../../../../../../tools/w800/ca/cakey.pem -sha1 -out "$ProjName"_sign.dat ./"$ProjName".img
  cat "$ProjName".img "$ProjName"_sign.dat > "$ProjName"_sign.img
  mv ./"$ProjName"_sign.img ../../../../../../../bin/w800/"$ProjName"_sign.img
  cat ../../../../../../../tools/w800/"$ProjName"_secboot.img ../../../../../../../bin/w800/"$ProjName"_sign.img > ../../../../../../../bin/w800/"$ProjName".fls  
 else
  mv ./"$ProjName".img ../../../../../../../bin/w800/"$ProjName".img
  cat ../../../../../../../tools/w800/"$ProjName"_secboot.img ../../../../../../../bin/w800/"$ProjName".img > ../../../../../../../bin/w800/"$ProjName".fls
fi

#produce compressed ota firmware*/
if [ $zip_type -eq 1 ]
 then
  if [ $signature -eq 1 ]
   then
    ../../../../../../../tools/w800/wm_tool.exe -b ./"$ProjName"_sign.img -o ../../../../../../../bin/w800/"$ProjName"_sign -it $img_type -fc 1 -ra 080d0400 -ih 080d0000 -ua 08010000 -nh 0  -un 0
    mv ../../../../../../../bin/w800/"$ProjName"_sign_gz.img ../../../../../../../bin/w800/"$ProjName"_sign_ota.img
  else
   ../../../../../../../tools/w800/wm_tool.exe -b ../../../../../../../bin/w800/"$ProjName".img -o ../../../../../../../bin/w800/"$ProjName" -it $img_type -fc 1 -ra 080d0400 -ih 080d0000 -ua 08010000 -nh 0  -un 0
   mv ../../../../../../../bin/w800/"$ProjName"_gz.img ../../../../../../../bin/w800/"$ProjName"_ota.img
  fi
fi
#openssl --help