# 矩阵分析

矩阵分析大体上算是线性代数的加强版

* 矩阵的代数结构和性质
* 矩阵在分析层面的问题

## 第一章 线性空间和线性变换

### 1.1 线性空间

#### 线性空间的定义

* 设$V$是一个非空的集合，$F$是一个数域，在集合V中定义两种代数运算,一种是加法运算，用“+”来表示，即任意$\alpha, \beta \in V$，则$\alpha + \beta \in V$ 。另一种是数乘运算，用来“•”表示，$\alpha \in V$，$k \in F$则. 并且这两种运算满足下列八条运算律：
* 加法交换律$\alpha + \beta = \beta + \alpha$
* 加法结合律$(\alpha + \beta) + \gamma = \alpha + (\beta + \gamma)$
* 零元素: 在V中存在一个元素0，使得对任意$\alpha \in V$，都有$\alpha + \mathbf{0} = \alpha$
* 负元素: 对于V中的任意元素$\alpha$都存在一个元素$\beta$使得$\alpha + \beta = \mathbf{0}$
* $1 \cdot \alpha = \alpha$
* $k\cdot (l \cdot \alpha) = (kl) \cdot \alpha$
* $(k + l) \cdot \alpha = k \cdot \alpha + l \cdot \alpha$
* $k \cdot (\alpha + \beta) = k \cdot \alpha + k \cdot \beta$

其中$k,l \in F$，称这样的$V$为数域$F$上的线性空间

设$A$是复数域$C$上的$m\times n$矩阵$x$为$n$维列向量，则$m$维列
向量的集合

$$
V = \{ y \in C^m | y = Ax, x \in C^n \}
$$

构成复数域 C 上的线性空间，称为 A 的列空间或A 的值域

#### 线性空间相关的相关概念

* 含有零向量的向量组一定线性相关
* 整体无关$\Rrightarrow$部分无关；部分相关$\Rrightarrow$整体相关
* 如果含有向量多的向量组可以由含有向量少的向量组线性表出，那么含有向量多的向量组一定线性相关
* 向量组的秩是唯一的，但是其极大线性无关并不唯一
* 如果向量组（I）可以由向量组（II）线性表出，那么向量组（I）
的秩≤向量组（II）的秩
* 等价的向量组秩相同

#### 线性空间的基底、维数、坐标

设数域F上的线性空间$V$中有$n$个线性无关的向量$\alpha_1,\alpha_2,\cdots,\alpha_n$，而$V$中任意一个向量$\alpha$都可由$\alpha_1,\alpha_2,\cdots,\alpha_n$线性表出，即

$$
\alpha = k_1 \alpha_1 + k_2 \alpha_2 + \cdots + k_n \alpha_n
$$

则称$\alpha_1,\alpha_2,\cdots,\alpha_n$为$V$的一个基底，$(k_1, k_2, \cdots , k_n)^T$为向量$\alpha$在基底$\alpha_1,\alpha_2,\cdots,\alpha_n$下的坐标,此时，称$V$为一个$n$维线性空间，记为$\mathrm{dim}V = n$

#### 基变换与坐标变换

设$\alpha_1, \alpha_2 , \cdots , \alpha_n$(旧基底)与$\beta_1, \beta_2, \cdots , \beta_n$(新基底)是是$n$维线性空间V
的两组基底，它们之间的关系为

$$
[\beta_1, \beta_2, \cdots ,\beta_n] = [\alpha_1, \alpha_2, \cdots, \alpha_n]\begin{bmatrix}
    a_{11} & a_{12} & \cdots & a_{1n}\\
    a_{21} & a_{22} & \cdots & a_{2n}\\
    \cdots & \cdots & \cdots & \cdots\\
    a_{n1} & a_{n2} & \cdots & a_{nn}\\
\end{bmatrix}
$$

$$
[\beta_1, \beta_2, \cdots ,\beta_n] = [\alpha_1, \alpha_2, \cdots, \alpha_n]P
$$

称$n$阶方阵$P$，是由旧基底到新基底的过渡矩阵,过渡矩阵$P$是可逆的

#### 线性子空间

设$V$为数域$F$上的一个$n$维线性空间,$W$为$V$的一个非空子集合，如果
对于任意的$\alpha , \beta \in W$,以及任意的$k,l\in F$,都有

$$
k\alpha + l \beta \in W
$$

那么我们称$W$为$V$的一个子空间

#### 子空间的交与和

设$V_1$和$V_2$是线性空间V的两个子空间，命

$$
\begin{matrix}
    V_1 \cap V_2  = \{\alpha|\alpha\in V_1 且\alpha \in V_2\}\\
    V_1 + V_2 = \{\alpha = \alpha_1 + \alpha_2|\alpha\in V_1 且\alpha \in V_2\}
\end{matrix}
$$

可以验证$V_1 \cap V_2$和$V_1+V_2$都构成$V$的线性子空间，分别称为$V_1$和$V_2$的**交空间**与**和空间**.

* 若$\alpha \in V_1$或$\alpha \in V_2 \Rightarrow \alpha \in V_1 + V_2$
* 若$\alpha \in V_1 + V_2 \not \Rightarrow \alpha \in V_1$或$\alpha \in V_2$
* 一般来说，$V_1 \cap V_2$不构成$V$的子空间，但满足

$$
V_1 \cup V_2 \sim V_1 + V_2
$$

并且，$V_1 + V_2$是$V$中包含$V_1 \cup V_2$的最小子空间

如果$V_1 \cap V_2 = \{\theta \}$,称和空间$V_1 + V_2$为**直和**，记为$V_1 \oplus V_2$
