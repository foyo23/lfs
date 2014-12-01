# select toolchain

case $LFS_TARGET_ARCH in
 arm) cross=/segfs/linux/dance_sdk/toolchain/arm-buildroot-linux-uclibcgnueabi-tango/bin/arm-buildroot-linux-uclibcgnueabi- ;;
 *) cross=$LFS_CROSS ;;
esac

# build zeromq

cd $LFS_THIS_SOFT_SRC/zeromq

CC=$cross\gcc \
CXX=$cross\g++ \
./configure \
--prefix=$LFS_TARGET_INSTALL_DIR \
--host=$LFS_TARGET_ARCH-linux \

make && make install


# build omnirb
# http://www.omniorb-support.com/omniwiki/CrossCompiling

cd $LFS_THIS_SOFT_SRC/omniORB

CC=$cross\gcc \
CXX=$cross\g++ \
./configure \
--prefix=$LFS_TARGET_INSTALL_DIR \
--host=$LFS_TARGET_ARCH-linux \
--build=x86_64-linux

make CC=gcc -C src/tool/omniidl/cxx/cccp
make CXX=g++ -C src/tool/omniidl/cxx
make CC=gcc -C src/tool/omkdepend
make && make install


# build tango

cd $LFS_THIS_SOFT_SRC/tango

CC=$cross\gcc \
CXX=$cross\g++ \
./configure \
--host=$LFS_TARGET_ARCH-linux \
--build=x86_64-linux \
--prefix=$LFS_TARGET_INSTALL_DIR \
--with-zlib=$LFS_TARGET_INSTALL_DIR \
--with-omni=$LFS_TARGET_INSTALL_DIR \
--with-zmq=$LFS_TARGET_INSTALL_DIR \
--disable-java

make && make install
