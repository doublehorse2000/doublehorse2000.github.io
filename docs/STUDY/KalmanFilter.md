# 卡尔曼滤波

## 递归算法

Optimal Recursire Data Processing Algorithm

* 不确定性
  * 不存在完美的数学模型
  * 系统的扰动不可控，也很难建模
  * 测量传感器存在误差

估真实数据 -> 取平均值

$$
\begin{array}{ll}
\hat{x}_k &= \frac{1}{k}(z_1 + z_2 + \cdots + z_k)\\
&=\frac{1}{k}(z_1 + z_2 + \cdots + z_{k-1}) + \frac{1}{k}z_k\\
&=\frac{k-1}{k}\hat{x}_{k-1} + \frac{1}{k}z_k\\
\end{array}
$$

因此有

$$
\begin{matrix}
  \hat{x}_k = \hat{x}_{k-1} + \frac{1}{k}(z_k - \hat{x}_{k-1})\\
\hat{x}_k = \hat{x}_{k-1} + K_k(z_k - \hat{x}_{k-1})\\
\mathrm{当前的估计值} = \mathrm{上一次的估计值} + \mathrm{系数} \times (\mathrm{当前测量值} - \mathrm{上一次的估计值})
\end{matrix}
$$

$K_k$：Kalman Gain 卡尔曼增益/因数

* 估计误差$e_{EST}$：估计值和真实值的差距
* 测量误差$e_{MEA}$：测量值与真实值的差距

$$
K_k = \frac{e_{EST_{k-1}}}{e_{EST_{k-1}}+e_{MEA_k}}
$$

讨论：在$k$时刻：

* $e_{EST_{k-1}} >> e_{MEA_{k}}\; k\rightarrow1\;\hat{x}_k = z_k$
* $e_{EST_{k-1}}<<e_{MEA_k}\;k\rightarrow 0\; \hat{x}_k = \hat{x}_{k-1}$

### 计算步骤

* Step1：计算Kalman Gain

$$
K_k = \frac{e_{EST_{k-1}}}{e_{EST_{k-1}}+e_{MEA_k}}
$$

* Step2：计算$\hat{x}_k$

$$
\hat{x}_k = \hat{x}_{k-1} + K_k(z_k - \hat{x}_{k-1})
$$

* Step3：更新$e_{EST_k}$

$$
e_{EST_k} = (1-K_k)e_{EST_{k-1}}
$$

## 数据融合

有两个秤，其测量的结果分别为$z_1,z_2$，标准差分别为$\sigma_1, \sigma_2$

$$
\begin{array}{ll}
z_1 = 30g & \sigma_1 = 2g\\
z_2 = 32g & \sigma_2 = 4g\\
\end{array}
$$

估计真实值$\hat{z}$

$$
\hat{z} = z_1 + K(z_1 - z_2)\;\;\;\;k\in[0,1]
$$

求K使得$\sigma_{\hat{z}}$最小->方差$Var(\hat{z})$最小

$$
\begin{array}{ll}
\sigma_{\hat{z}}^2 &= Var(z_1 + k(z_2 - z_1))\\  
&= Var((1-k)z_1 + kz_2)\\
&= Var((1-k)z_1) + Var(kz_2)\\
&= (1-k)^2 Var(z_1) + k^2 Var(z_2)\\
&= (1-k)^2 \sigma_1^2 + k^2 \sigma_2^2
\end{array}
$$

$$
\frac{d \sigma_{\hat{z}}^2}{dk} = 0\\
k = \frac{\sigma_1^2}{\sigma_1^2 + \sigma_2^2}\\
$$

## 协方差矩阵

$$
P = \begin{bmatrix}{}
\sigma_x^2 & \sigma_x \sigma_y & \sigma_x \sigma_z\\
\sigma_y \sigma_x & \sigma_y^2 & \sigma_y \sigma_z\\
\sigma_z \sigma_x & \sigma_z \sigma_y & \sigma_z^2
\end{bmatrix}
$$

* 其中对角线上的元素比较熟悉，是方差其公式为

$$
\sigma_{x}^2 = \frac{1}{n} \sum_{i = 1}^{n}(x_i - \bar{x})^2
$$

* 其他元素为协方差，表示了两个变量之间的关系

$$
\sigma_x \sigma_y = \frac{1}{n}\sum_{i = 1}^{n}(x_i - \bar{x})(y_i - \bar{y}) = \sigma_y \sigma_x
$$

* 计算机编程求解协方差矩阵可以

$$
a = \begin{bmatrix}
  x_1 & y_1 & z_1 \\
  x_2 & y_2 & z_2 \\
  x_3 & y_3 & z_3 \\
\end{bmatrix} - \frac{1}{3}\begin{bmatrix}
  1 & 1 & 1\\
  1 & 1 & 1\\
  1 & 1 & 1\\
\end{bmatrix} \begin{bmatrix}
  x_1 & y_1 & z_1 \\
  x_2 & y_2 & z_2 \\
  x_3 & y_3 & z_3 \\
\end{bmatrix}
$$

$$
P = \frac{1}{3}a^Ta
$$

## 卡尔曼增益/因数详细推导

状态空间方程

$$
x_k = Ax_{k-1} + Bu_{k-1} + w_{k-1}\\
z_k = Hx_k + v_k
$$

> * 其中$w_{k-1}$为过程噪声，服从$p(w)\sim(0,Q)$的正态分布，$0$代表了正态分布的期望为$0$，$Q$为协方差矩阵
>
> $$
> Q = E\left[
> \begin{array}{}
> w & w^T
> \end{array}{}
> \right]
> =E\left[
> \left[
> \begin{array}{}
> w_1\\
> w_2
> \end{array}{}
> \right]
> \left[
> \begin{array}{}
> w_1 & w_2
> \end{array}{}
> \right]
> \right] = \left[
> \begin{array}{}
> E(w_1^2)=\sigma_{w_1}^2 & E(w_1w_2)=\sigma_{w_1}\sigma_{w_2}\\
> E(w_2w_1)=\sigma_{w_2}\sigma_{w_1} & E(w_2^2) = \sigma_{w_2}^2
> \end{array}{}
> \right]
> $$
>
> $$
> VAR(X) = E(X^2) - E^2(X)
> $$
>
> * 其中$v_k$为测量噪声，服从$p(v)\sim (0,R)$的正态分布

由于不知道过程噪声，因此根据上一次的实际量和上一次的控制量，可以写出状态空间方程

$$
\hat{x}_{\bar{k}} = Ax_{k-1} + Bu_{k-1}\\
z_k = Hx_k \rightarrow \hat{x}_{MEA_k} = H^- z_k\\
$$

> 其中$\hat{x}_{\bar{k}}$代表了状态量的先验估计，因此后面不带过程噪声

因此可以通过测量的量和先验估计量来估计一个统计概率上最优的解

$$
\hat{x}_k = \hat{x}_{\bar{k}} + G(H^- z_k - \hat{x}_{\bar{k}})\;\;\;G\in[0,1]\\
$$

令$G = K_k H$

$$
\hat{x}_k = \hat{x}_{\bar{k}} + K_k(z_k - H\hat{x}_{\bar{k}})\;\;K_k \in[0, H^-]
$$

寻找$K_k$使得$\hat{x}_k$最接近$x_k$

令$e_k = x_k - \hat{x}_k$，求解使$P=E[e e^T]$最小的$K_k$的数值

首先化简一下$e_k$

$$
\begin{array}{ll}
x_k - \hat{x}_k &= x_k - (\hat{x}_{\bar{k}} + K_k(z_k - H\hat{x}_{\bar{k}})) \\
&= x_k - \hat{x}_{\bar{k}} - K_kz_k + K_kH\hat{x}_{\bar{x}}\\
& = x_k - \hat{x}_{\bar{k}} - K_kHx_k - K_kv_k + K_kH\hat{x}_{\bar{x}}\\
&= (x_k - \hat{x}_{\bar{k}}) - K_kH(x_k - \hat{x}_{\bar{k}}) - K_kv_k\\
&= (I - K_kH)(x_k - \hat{x}_{\bar{k}})- K_kv_k\\
&= (I - K_kH)e_{\bar{k}} - K_kv_k\\
\end{array}
$$

$$
\begin{array}{ll}
  P&=E[e e^T]\\
  &= E[(x_k - \hat{x}_{\bar{k}})(x_k - \hat{x}_{\bar{k}})^T]\\
  &= E[((I - K_kH)e_{\bar{k}}- K_kv_k)((I - K_kH)e_{\bar{k}}- K_kv_k)^T]\\
  &= E[((I - K_kH)e_{\bar{k}}- K_kv_k)(e_{\bar{k}}^T(I - K_kH)^T- v_k^TK_k^T)]\\
\end{array}
$$

可以将上述的等式拆成四个部分，分别为

$$
\begin{array}{ll}
  E[(I - K_kH)e_{\bar{k}}e_{\bar{k}}^T(I-K_kH)^T]\\\\
  E[(I - K_kH)e_{\bar{k}}v_k^TK_k^T]\\\\
  E[K_kv_ke_{\bar{k}}^T(I - K_kH)^T]\\\\
  E[K_kv_kv_k^TK_k^T]\\\\
\end{array}
$$

针对第二项和第三项可以有

$$
\begin{array}{ll}
  E[(I - K_kH)e_{\bar{k}}v_k^TK_k^T] &= (I - K_kH)E[e_{\bar{k}}v_k^TK_k^T]\\
  &= (I - K_kH)E[e_{\bar{k}}]\cdot E[v_k^T] K_k^T\\
  &= 0\\
  E[K_kv_ke_{\bar{k}}^T(I - K_kH)^T] &= K_kE[v_k]\cdot E[e_{\bar{k}}^T](I - K_kH)^T\\
  &= 0\\
\end{array}
$$

针对第一项有

$$
\begin{array}{ll}
  E[(I - K_kH)e_{\bar{k}}e_{\bar{k}}^T(I-K_kH)^T] &= (I-K_kH)E[e_{\bar{k}}e_{\bar{k}}^T](I-K_kH)^T \\
  &= (I-K_kH)P_{\bar{k}}(I-K_kH)^T\\
  &= (P_{\bar{k}} - K_kHP_{\bar{k}})(I - H^TK_k^T)\\
  &= P_{\bar{k}} - K_kHP_{\bar{k}} - P_{\bar{k}}H^TK_k^T + K_kHP_{\bar{k}}H^TK_k^T
\end{array}
$$

针对第四项有

$$
\begin{array}{ll}
  E[K_kv_kv_k^TK_k^T] &= K_kRK_k^T
\end{array}
$$

综上有

$$
\begin{array}{ll}
  P = P_{\bar{k}} - K_kHP_{\bar{k}} - P_{\bar{k}}H^TK_k^T + K_kHP_{\bar{k}}H^TK_k^T + K_k R K_k^T
\end{array}
$$

需要寻找$tr(P)$最小

$$
tr(P) = tr(P_{\bar{k}}) - 2tr(K_kHP_{\bar{k}}) + tr(K_kHP_{\bar{k}}H^TK_k^T) + tr(K_k R K_k^T)
$$

$$
\begin{array}{ll}
  \frac{\mathrm{d}tr(P)}{\mathrm{d}K_k} &= 0 - 2 (HP_{\bar{k}})^T + 2K_kHP_{\bar{k}}H^T + 2K_kR\\
  & = 0
\end{array}
$$

$$
  -P_{\bar{k}}H+K_k(HP_{\bar{k}}H^T+R) = 0
$$

$$
K_k = \frac{P_{\bar{k}}H^T}{HP_{\bar{k}}H^T+R}
$$

> $$
> \frac{\mathrm{d}tr(AB)}{\mathrm{d}A} = B^T
> $$
>
> $$
> \frac{\mathrm{d}tr(ABA^T)}{\mathrm{d}A} = A(B + B^T)
> $$
>

* 当$R \rightarrow \infty$时，说明测量噪声很大，$K_k \rightarrow 0, \hat{x}_k \rightarrow \hat{x}_{\bar{k}}$
* 当$R \rightarrow 0$时，说明测量噪声很小，$K_k \rightarrow H^-,\hat{x}_k \rightarrow H^-z_k$
