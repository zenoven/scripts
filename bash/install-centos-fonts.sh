#!/bin/bash
fonts_base=/usr/share/fonts
customize_dir_name=customize
fonts_dir="${fonts_base}/${customize_dir_name}"
commands=(wget mkfontscale mkfontdir)

# 判断一个命令是否存在
commanExists(){
  # 0不存在  1存在
  exists=0
  if command -v $1 >/dev/null 2>&1; then
    exists=1
  fi
  return $exists
}

# 安装某个命令
installCommand(){
  commanExists $1
  exists=$?
  if [ $exists -eq 0 ]; then
    echo "${$1} not installed, start installing..."
    yum -y install $1
    if $? -eq 0; then
      echo "${$1} installed successfully"
    else
      echo "${$1} fontconfig failed"
    fi
  fi
}

download(){
  wget -c --no-verbose $1 -O $2
}

for command in ${commands[@]}; do
  installCommand $command
done

if [ ! -d $fonts_dir ]; then
  su
  cd $fonts_base
  mkdir $customize_dir_name
  cd $customize_dir_name
fi

cd $fonts_dir

for font in $@; do
  name=${font##*/}
  name=customize_$name
  name=${fonts_dir}/${name}
  echo "## downloading font from ${font} ..."
  download $font $name
  echo "## ${font} downloaded successfully"
done

mkfontscale
mkfontdir
fc-cache