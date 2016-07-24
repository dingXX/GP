# GP
##基于matlab激光雷达点云数据中电力线提取与拟合
###电力线点云分割  
* ETS.m  
高程迭代阈值分割法，将地形点（高程低点滤除）
* extractPoint.m  
提取电力线点，用到elliNeighbour.m与cov_eig.m  
根据每个点的邻域点是否为一维
* elliNeighbour.m  
找出点的椭球邻域
* cov_eig.m  
根据邻域点求邻域的协方差，再求协方差特征值，只有一个大特征值，则为一维  
###电力线点云分割   
* point2lines.m  
根据电力线点云求电力线在XOY面上的直线方程  
用到gethoughline.m
* gethoughline.m  
对二值图像进行hough变换，求图像中的直线
* getLinePoints.m  
求出单条电力线的点云  
用到equpt2linept.m
* equpt2linept.m  
根据同一直线方程附近的点云求单条电力线的点云  
###电力线拟合  
* centerLine.m  
电力线点云XOY面的中心走向线  
* xyz2dz.m  
xyz格式转换为拟合平面坐标  
* fitting.m  
最小二乘法拟合  
* curveShow.m  
拟合曲线三维重建  
###海量数据处理
* chunkLas.m  
分块读取Las文件
* getLinePtByChunk.m
分块分割电力线点云  
###总程序  
code.m  