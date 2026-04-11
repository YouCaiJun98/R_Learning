# 1、导入tianmaoTV.xlsx，并把数据集命名成tianmao_2，以下操作都基于tianmao_2数据集
# 2、提取当前价格(current_price)小于1000的所有观测
# 3、在数据集tianmao_2中生成一个新列，将新列命名为stock_class。
# 当库存（stock）等于0，stock_class的值为'无货'；
# 库存（stock）小于100，stock_class的值为'低库存'；
# 库存（stock）大于等于100，stock_class的值为'高库存'
# 4、提取tianmao_2的stock、stock_class两列
# 5、将列名为"shop_id","shop_name" 的两列删除掉