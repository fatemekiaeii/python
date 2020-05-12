import codecademylib
import pandas as pd
inventory=pd.read_csv('inventory.csv')
staten_island=inventory.head(10)
product_request=staten_island.product_description
print(staten_island)

seed_request=inventory[(inventory.location=="Brooklyn") &(inventory.product_type=="seeds")]

inventory['in_stock']=inventory.quantity.apply(lambda x:
"True" if x>0   else("False" if x==0 else x) )

inventory["total_value"]=inventory.price * inventory.quantity

combine_lambda = lambda row:\
" {}  -{} ".format(row.product_type , 
row.product_description)



inventory['full_description']=inventory.apply(combine_lambda, axis=1)


