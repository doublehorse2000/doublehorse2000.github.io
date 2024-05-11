# Casadi学习笔记

## Linux环境配置

* 本环境配置Casadi在Linux下通过C++ API进行开发，因此没有安装python相关接口
* 环境为Ubuntu 22.04
* IDE为Clion

### 1.安装必要的编译器

```shell
sudo apt install gcc g++ gfortran git cmake liblapack-dev pkg-config --install-recommends
```

### 2.安装前置的非线性求解器IPOPT

#### 2.1 命令行安装（估计不行）

```shell
sudo apt-get install coinor-libipopt
```

估计会产生报错，因此采用源码安装的方式

#### 2.2 源码安装

**下载必要的编译器**

```shell
sudo apt-get install gcc g++ gfortran git patch wget pkg-config liblapack-dev libmetis-dev
```

**下载、构建、安装必要的依赖库**

* ASL(Ampl Solver Library)

```sh
git clone https://github.com/coin-or-tools/ThirdParty-ASL.git
cd ThirdParty-ASL
./get.ASL
./configure
make
sudo make install
```

* HSL

```shell
git clone https://github.com/coin-or-tools/ThirdParty-HSL.git
cd ThirdParty-HSL
```

前往[Coin-HSL](https://licences.stfc.ac.uk/product/coin-hsl)获取源码，重命名为`coinhsl`，在上述文件解压。

```sh
./configure
make -j4
sudo make install
```

* MUMPS Linear Solver

```shell
git clone https://github.com/coin-or-tools/ThirdParty-Mumps.git
cd ThirdParty-Mumps
./get.Mumps
./configure
make
sudo make install
```

**获取Ipopt源码**

```shell
git clone https://github.com/coin-or/Ipopt.git
cd Ipopt
mkdir build
cd build
sudo ../configure
sudo make
sudo make test
sudo make install
```

**完善环境**

```sh
cd /usr/local/include
sudo cp coin-or coin -r
sudo ln -s /usr/local/lib/libcoinmumps.so.3 /usr/lib/libcoinmumps.so.3
sudo ln -s /usr/local/lib/libcoinhsl.so.2 /usr/lib/libcoinhsl.so.2
sudo ln -s /usr/local/lib/libipopt.so.3 /usr/lib/libipopt.so.3
```

### 3.安装casadi

```shell
git clone https://github.com/casadi/casadi.git -b main casadi
cd casadi
mkdir build
cd build
cmake .. -DWITH_IPOPT=ON -DWITH_EXAMPLES=OFF
make
sudo make install
```

## Casadi基本概念
