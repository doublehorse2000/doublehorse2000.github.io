# 模型预测控制

模型预测控制广泛应用于工业控制领域的高级控制策略。

## 一、模型预测控制的基本概念

* MPC是一种**滚动优化**的控制方法，在每个采样的时间内，对未来某段时间进行最优化控制，选取第一个控制量
输出到系统中

## 二、二次规划问题

* MPC求解最优化问题需要用到二次规划问题，二次规划问题的标准型为

$$
\min_{u}J=\frac{1}{2}u^THu+u^Tf
$$

$$
\begin{array}{ll}
    s.t. & Mu \leq b\\
    & M_{eq}u = b_{eq}\\
    & LB \leq u \leq UB\\
\end{array}
$$

可以利用相关软件求解最优的$u$的数值

## 三、模型预测控制推导

### 3.1 线性离散系统转换为标准形式

状态空间方程为

$$
x_{[k+1]} = Ax_{[k]}+Bu_{[k]}
$$

定义二次型性能指标为

$$
J = \frac{1}{2}x^T_{[N_p]}Sx_{[N_p]} + \frac{1}{2}\sum_{k = 0}^{N_p - 1}[x^T_{[k]}Qx_{[k]} + u^T_{[k]}Ru_{[k]}]
$$

分别代表了末端代价、运行代价和控制量代价的权重矩阵

$$
\begin{array}{ll}
    x_{[k+1|k]} &= Ax_{[k|k]} + Bu_{[k|k]}\\
    x_{[k+2|k]} &= A^2x_{[k|k]} + ABu_{[k|k]} + Bu_{[k+1|k]}\\
    \vdots &= \vdots\\
    x_{[k+N_p]} &= A^{N_p}x_{[k|k]} + A^{N_p - 1}Bu_{[k|k]} + \cdots + ABu_{[k+N_p-2|k]} + Bu_{[k+N_p - 1|k]}\\
\end{array}
$$

令

$$
X_{[k]} = \begin{bmatrix}
    x_{[k+1|k]}\\
    x_{[k+2|k]}\\
    \vdots\\
    x_{[k+N_p|k]}\\
\end{bmatrix}_{(nN_p)\times 1} U_{[k]} = \begin{bmatrix}
    u_{[k|k]}\\
    u_{[k+1|k]}\\
    \vdots\\
    u_{[k+N_p-1]k}
\end{bmatrix}_{(pN_p)\times 1}
$$

可以得到

$$
X_{[k]} = \Phi x_{[k|k]} + \Gamma U_{[k]}
$$

其中

$$
\Phi = \begin{bmatrix}
    A\\
    A^2\\
    \vdots\\
    A^{N_p}
\end{bmatrix} \Gamma = \begin{bmatrix}
    B & 0 &\cdots & 0\\
    AB & B & \cdots & 0\\
    \vdots & \vdots & \cdots &\vdots\\
    A^{N_p -1} & A^{N_p -2}B & \cdots & B
\end{bmatrix}
$$

我们的目标是设计程序找到$U_{[k]}^*$让$J$的数值最小

### 3.2 转换成二次型标准问题

性能指标可以写成

$$
J = \frac{1}{2}x^T_{[k+N_p|k]}Sx_{[k+N_p|k]} + \frac{1}{2}\sum_{i = 0}^{N_p - 1}[x^T_{[k+i|k]}Qx_{[k+i|k]} + u^T_{[k+i|k]}Ru_{[k+i|k]}]
$$

$$
J = \frac{1}{2}x^T_{[k|k]}Qx_{[k|k]} + \frac{1}{2}x^T_{[k+N_p|k]}Sx_{[k+N_p|k]} + \frac{1}{2}\sum_{i = 1}^{N_p - 1}x^T_{[k+i|k]}Qx_{[k+i|k]} + \frac{1}{2}\sum_{i = 0}^{N_p - 1}u^T_{[k+i|k]}Ru_{[k+i|k]}
$$

$$
J = \frac{1}{2}x^T_{[k|k]}Qx_{[k|k]} + \frac{1}{2}X^T_{[k]} \begin{bmatrix}
    Q & \cdots & 0\\
    \vdots & Q & \vdots\\
    0 & \cdots & S\\
\end{bmatrix}X_{[k]} + \frac{1}{2}U_{[k]}\begin{bmatrix}
    R & \cdots & 0\\
    \vdots & \ddots &\vdots\\
    0 & \cdots & R\\
\end{bmatrix} U_{[k]}
$$

定义

$$
\Omega = \begin{bmatrix}
    Q & \cdots & 0\\
    \vdots & Q & \vdots\\
    0 & \cdots & S
\end{bmatrix} \Psi = \begin{bmatrix}
    R & \cdots & 0\\
    \vdots & \ddots & \vdots\\
    0 & \cdots & R\\
\end{bmatrix}
$$

$$
J = \frac{1}{2}x^T_{[k|k]}Qx_{[k|k]} + \frac{1}{2}X^T_{[k]} \Omega X_{[k]} + \frac{1}{2}U_{[k]}^T \Psi U_{[k]}
$$

把$X_{[k]},U_{[k]}$的等式带入上面的式子，经过一波猛烈的化简可以得到

$$
J = \frac{1}{2}x^T_{[k|k]}(Q + \Phi^T \Omega \Phi)x^T_{[k|k]} + U_{[k]}^T\Gamma^T\Omega\Phi x_{[k|k]} + \frac{1}{2}U_{[k]}^T (\Gamma^T \Omega \Gamma + \Psi)U_{[k]}
$$

第一项是常数，可以得到

$$
J = U_{[k]}^T\Gamma^T\Omega\Phi x_{[k|k]} + \frac{1}{2}U_{[k]}^T (\Gamma^T \Omega \Gamma + \Psi)U_{[k]}
$$

令

$$
\begin{cases}
    F &= \Gamma^T \Omega \Phi\\
    H &= \Gamma^T\Omega\Gamma + \Psi\\
\end{cases}
$$

可以得到

$$
J = U_{[k]}^T F x_{[k|k]} + \frac{1}{2}U_{[k]}^T H U_{[k]}
$$
