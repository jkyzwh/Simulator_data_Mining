
library(ggplot2)


# 1. fun_rename_data: 原始数据数据列名的标准化-----------------
#函数使用条件为已经完成了驾驶模拟实验数据的导入
#函数的基本功能为替换为更容易理解的变量名

fun_rename_data<- function(data) 
{ #data为导入的原始数据
  #为数据框各列重新命名为简洁易理解的名字
  data_name<- c("Time",                     # 锘縠lapsed.time.s.,       # 场景时间，s
                "Time_carsim",              # CarSim.TruckSim.time.s.,  # CarSim/TruckSim时间，s
                "Ab_time",                  # absolute.time,            # 主机电脑时间，hh:mm:ss:ms
                "Car_type",                 # car.type,                 # 车型
                "Car_name",                 # name,                     # 车辆名称
                "ID",                       # ID,
                "Position_x",               # position.x.,              # 世界坐标系x坐标
                "Position_y",               # position.y.,              # 世界坐标系y坐标
                "Position_z",               # position.z.,              # 世界坐标系z坐标
                "Direction_x",              # direction.x.,
                "Direction_y",              # direction.y.,
                "Direction_z",              # direction.z.,
                "Yaw",                      # yaw.rad.,                 # 偏航角，rad
                "Pitch",                    # pitch.rad.,               # 纵摇角，rad
                "Roll",                     # roll.rad.,                # 翻滚角，rad
                "Intersection",             # in.intersection,          # 是否为交叉口
                "Rd",                       # road,                     # 道路名称
                "Dis",                      # distance.from.road.start, # 距离道路起点位置，m
                "Rd_width",                 # carriage.way.width,       # 模拟车所在道路宽度，m
                "Left_bd",                  # left.border.distance,     # 模拟车距离道路左侧边缘位置，m
                "Right_bd",                 # right.border.distance,    # 模拟车距离道路右侧边缘位置，m
                "Tral_dis",                 # traveled.distance,        # 模拟车行驶距离，m
                "Lane_dir",                 # lane.direction.rad.,      # 道路方向，rad
                "Lane_num",                 # lane.number,              # 模拟车所在车道号
                "Lane_width",               # lane.width,               # 模拟车所在车道宽度，m
                "Lane_offset",              # lane.offset,              # 模拟车偏离所在车道中心线距离，m
                "Rd_offset",                # road.offset,              # 模拟车偏离所在道路中心线距离，m
                "Lateral_slope",            # road.lateral.slope.rad.,  # 道路横坡，rad
                "Longitudinal_slope",       # road.longitudinal.slope,  # 道路纵坡
                "Gear",                     # gear,                     # 模拟车行驶档位
                "Light",                    # light.status,             # 车灯状态
                "RPM",                      # rpm,                      # 模拟车转速
                "Speed",                    # speed.m.s.,               # 车速，m/s
                "Speed_x",                  # speed.vector_x.m.s.,      # 车速在x方向分量，m/s
                "Speed_y",                  # speed.vector_y.m.s.,      # 车速在y方向分量，m/s
                "Speed_z",                  # speed.vector_z.m.s.,      # 车速在z方向分量，m/s
                "Acc_sway",                 # local.acceleration_sway.m.s.2.,            # 模拟车横向加速度，m/s^2
                "Acc_heave",                # local.acceleration_heave.m.s.2.,           # 模拟车垂直加速度，m/s^2
                "Acc_surge",                # local.acceleration_surge.m.s.2.,           # 模拟车纵向加速度，m/s^2
                "Yaw_speed",                # rotation.speed_yaw.rad.s.,                 # 模拟车yaw角速度，rad/s
                "Pitch_speed",              # rotation.speed_pitch.rad.s.,               # 模拟车pitch角速度，rad/s
                "Roll_speed",               # rotation.speed_roll.rad.s.,                # 模拟车roll角速度，rad/s
                "Acc_yaw",                  # rotation.acceleration_yaw.rad.s.2.,        # 模拟车yaw角加速度，rad/s^2
                "Acc_pitch",                # rotation.acceleration_pitch.rad.s.2.,      # 模拟车pitch角加速度，rad/s^2
                "Acc_roll",                 # rotation.acceleration_roll.rad.s.2.,       # 模拟车roll角加速度，rad/s^2
                "Steering",                 # steering,                 # 方向盘转角
                "Acc_pedal",                # acceleration.pedal,       # 加速踏板踩踏深度
                "Brake_pedal",              # brake.pedal,              # 制动踏板踩踏深度
                "Clutch_pedal",             # clutch.pedal,             # 离合踏板踩踏深度
                "Hand_brake",               # hand.brake,               # 手刹状态
                "Key",                      # ignition.key,             # 钥匙开关是否激活
                "Gear_level",               # gear.lever,               # 模拟车行驶档位
                "Wiper",                    # wiper,                    # 雨刷状态
                "Horn",                     # horn,                     # 喇叭状态
                "Car_weight",               # car.weight.kg.,           # 模拟车质量，kg
                "Car_wheelbase",            # car.wheelbase,            # 模拟车轴距，m
                "Car_width",                # car.width,                # 模拟车宽度，m
                "Car_length",               # car.length,               # 模拟车长度，m
                "Car_height",               # car.height,               # 模拟车高度，m
                "front_left_wheel_x",
                "front_left_wheel_y",
                "front_right_wheel_x",
                "front_right_wheel_y",
                "rear_left_wheel_x",
                "rear_left_wheel_y",
                "rear_right_wheel_x",
                "rear_right_wheel_y",
                "TTC_front",                # front.vehicle.TTC.s.,       # 前车TTC，车速小于前车，输出n/a
                "Dis_front",                # front.vehicle.distance.m.,  # 前车距离
                "TTC_rear",                 # rear.vehicle.TTC.s.,        # 后车TTC
                "Dis_rear",                 # rear.vehicle.distance.m.,   # 后车距离
                "Speed_rear",               # rear.vehicle.speed.m.s.,    # 后车速度，m/s
                "road_bumps",
                "Scen"                      # scenario.name               # 场景名称
  )
  names(data) <- data_name
  return(data)
}

# 2. 按桩号排列数据  ####    
Order.dis <- function(data, step=1){      # data为数据集，step为排列间距
  data$Dis <- data$Dis%/%step*step 
  end=length(data$Dis)
  order <- c()
  for(i in 1:end){
    if(i==1){
      k=1
      order[1]=1
    }
    else if(data$Dis[i]!=data$Dis[i-1])
    {k=k+1
    order[k]=i
    }      
  }
  return(data[order,])
}


# 3. 按时间排列数据 #####
Order.time <- function(data, step=1){     # data为数据集，step为排列间距
  data$Time <- data$Time%/%step*step 
  end <- length(data$Time)
  order <- c()
  for(i in 1:end){
    if(i==1){
      k=1
      order[1]=1
    }
    else if(data$Time[i]!=data$Time[i-1])
    {k=k+1
    order[k]=i
    }      
  }
  return(data[order,])
}

#4 定义一个函数，计算每一行数据相对于上一行的变化#######################

Raw.minus <- function(data_input)
{
  data<-subset(data_input, select=c("Speed",          
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
  
  for (i in 2:length(data$Speed))
  {
    if (i==2){aa<-data[i,]-data[(i-1),]}
    if(i>2)
    {
      aaa<-data[i,]-data[(i-1),]
      aa<-rbind(aa,aaa) 
    }
  } 
  return(aa)
}

 
#5 定义一个函数，生成arules包要求的购物篮数据结构transactions
#data_input 要求为计算逐行差异的绝对值数据框

data_arules.transactions <- function(data_input,a=0.50)
{
  library(arules) #Apriori 算法功能包
  # 利用指定的（50%）分位数作为判断参数是否出现重大变化的依据，
  # 方法是计算各数值与50分位数差值，差值大于0说明出现重大变化
  # 所有列减去a分位数(默认是50分位数)
  for (i in 1:length(data_input))
  {
    c<-quantile(data_input[,i],c(a))
    data_input[,i]<-data_input[,i]-c
  } 
  # 将差值后的数据框进行标准化，小于零的均定义为零，大于零的定义为1
  for(i in 1:length(data_input))
  {
    for(j in 1:length(data_input$Speed))
    {
      if(data_input[j,i]<=0)
      {data_input[j,i]<-0}
      if(data_input[j,i]>0)
      {data_input[j,i]<-1}
    }
  }
  # 转换为矩阵
  aaa<-as.matrix(data_input)
  #aaa<-t(aaa)#转置
  aaa<- as(aaa, "transactions") #转换为transaction结构
  return(aaa)
}
