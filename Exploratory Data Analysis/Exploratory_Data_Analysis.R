# 程序功能说明----------------------------------------------------------------------------------------
#不能源程序用于建立关联规则算法，用于分析驾驶模拟数据中潜藏的内在关联关系
#程序功能说明结束，程序中使用的函数与变量定义---------------------------------------------------------

# 导入需要的package

library(ggplot2)
library(arules) #Apriori 算法功能包

# 导入需要的标准函数功能源文件
source("D:/PROdata/R/Simulator data mining project/Exploratory Data Analysis/Fun_Exploratory_Data_Analysis.R")


# 输入文件：
#  驾驶模拟实验数据


# 1. 驾驶模拟实验数据导入 ##############
setwd("D:/PROdata/R/Data/S_Z") #标准测试数据集目录

temp<- list.files(pattern="*.csv")#查询当前目录下包含的所有csv文件，将文件名存入temp列表
data_name<-gsub('.csv','',temp)#将文件名的扩展名去掉，即将文件名中的.csv替换为空，存入data_name列表
for (i in 1:length(temp))
{
  #将每个读入csv生成的数据框赋值给对应的变量名
  assign(data_name[i], read.table(file=temp[i],header=T,sep=",",stringsAsFactors =FALSE ))
  aa<-get(data_name[i])
  # 数据列名称标准化
  aa<-fun_rename_data(aa)
  # 选择需要的数据列
  aa<-subset(aa, select=c("Time",         
                            "Dis",            
                            "Speed",          
                            "Acc_surge",      
                            "Acc_sway",
                            "Yaw",                # 偏航角，rad
                            "Lane_offset",        # 模拟车偏离所在车道中心线距离，m
                            "Yaw_speed",          # 模拟车yaw角速度，rad/s
                            "Acc_yaw",            # 模拟车yaw角加速度，rad/s^2
                            "Steering",           # 方向盘转角
                            "Acc_pedal",          # 加速踏板踩踏深度
                            "Brake_pedal"         # 制动踏板踩踏深度
                          )
  )
  # 将数据列按照空间序列排序，间距为1米，排序
  aa<-Order.time(aa,step=1)
  # 增加ID列，将文件名/的前两位/（被试编号）赋值给driver_ID
  #aa$driver_ID<-as.numeric(substr(data_name[i],1,2))
  #aa$driver_ID<-data_name[i]
  # 将调整过的aa重新赋值给data_name对应的变量
  assign(data_name[i],aa)
  rm(aa)
}

# 将所有驾驶员数据整合成一张大表
data.all<-data.frame()
for (i in 1:length(data_name))
{
  #利用get()获取data_name中储存的变量名对应的变量，并赋值给中间变量aa
  aa<-get(data_name[i])
  #将变量一次连接，形成新的数据框
  data.all<-rbind(aa,data.all)
}
rm(aa)

#####################################################################
# 利用Raw.minus函数计算各行之间的差异，并取绝对值
#aa<-abs(Raw.minus(A))
# 生成购物篮算法需要的数据结构
data.apriori<-data_arules.transactions(abs(Raw.minus(data.all)),a=0.5)

#########################################################
# 可视化分析
# 可视化支持度大于10%的事项
itemFrequencyPlot(data.apriori,support=0.1)
#可视化支持度最高的5个事项
itemFrequencyPlot(data.apriori,topN=5)
#前100次事项的稀疏矩阵
image(data.apriori[1:100])

###################################################

#计算关联规则
rule<-apriori(data = data.apriori,parameter = list(support=0.3,confidence=0.8,minlen=1))
inspect(rule)









