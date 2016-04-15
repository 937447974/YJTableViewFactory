#!/bin/sh

#路径声明
docset_name = com.YJFactory.YJTableViewFactory.docset
docset_path = Documentation/${docset_name}
docset_dest_dir = ~/Library/Developer/Shared/Documentation/DocSets
docset_dest_path = ${docset_dest_dir}/${docset_name}

#对比已有的文档，如果有不同则用最新的覆盖已有的
diff --recursive ${docset_path} ${docset_dest_path} > /dev/null
if [[ $? != 0 ]] ; then
	#目录不存在则创建
	if [ ! -d ${docset_dest_dir} ]; then
  		mkdir -p ${docset_dest_dir}
	fi
	
	#复制文件
	cp -a -f ${docset_path} ${docset_dest_path}
	
	#在通知中心显示提示
	osascript -e 'display notification "重启XCode后,在Help -> Document And API Reference中查看文档" with title "YJTableViewFactory开发文档已安装！"'
fi