ICON_FILE=$1

mkdir logo.iconset

sips -z 20 20 $ICON_FILE --out logo.iconset/icon_20.png

sips -z 29 29 $ICON_FILE --out logo.iconset/icon_29.png

sips -z 40 40 $ICON_FILE --out logo.iconset/icon_40.png

sips -z 58 58 $ICON_FILE --out logo.iconset/icon_58.png

sips -z 60 60 $ICON_FILE --out logo.iconset/icon_60.png

sips -z 76 76 $ICON_FILE --out logo.iconset/icon_76.png

sips -z 80 80 $ICON_FILE --out logo.iconset/icon_80.png

sips -z 87 87 $ICON_FILE --out logo.iconset/icon_87.png

sips -z 120 120 $ICON_FILE --out logo.iconset/icon_120.png

sips -z 152 152 $ICON_FILE --out logo.iconset/icon_152.png

sips -z 167 167 $ICON_FILE --out logo.iconset/icon_167.png

sips -z 180 180 $ICON_FILE --out logo.iconset/icon_180.png

sips -z 1024 1024 $ICON_FILE --out logo.iconset/icon_1024.png

#iconutil -c icns logo.iconset