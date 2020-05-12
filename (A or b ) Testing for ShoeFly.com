# python
Data analysis with python

import codecademylib
import pandas as pd

ad_clicks = pd.read_csv('ad_clicks.csv')
print(ad_clicks.head(10))

print(ad_clicks.groupby('utm_source').user_id.max(). reset_index())

 
ad_clicks['is_click']=~ad_clicks\
.ad_click_timestamp.isnull()

clicks_by_source=ad_clicks\
.groupby(['utm_source','is_click'])\
.user_id.count()\
.reset_index()



clicks_pivot=clicks_by_source\
.pivot(columns='is_click',
  index="utm_source",
  values='user_id')\
.reset_index()
print(clicks_pivot)

clicks_pivot['precent_clicked']=\
clicks_pivot[True]/\
(clicks_pivot[True]+clicks_pivot[False])

print(
  ad_clicks\
  .groupby("experimental_group")\
  .user_id.count()\
  .reset_index()
)

print(ad_clicks.groupby(['is_click',"experimental_group"])\
.user_id.count().reset_index())



a_clicks=ad_clicks[ad_clicks.experimental_group=="A"]
b_clicks=ad_clicks[ad_clicks.experimental_group=="B"]

print(a_clicks)
print(b_clicks)

percent_a=a_clicks.groupby(['is_click','day']).user_id.count().reset_index()

pivot_a=percent_a.pivot(
  columns='is_click',
  index='day',
  values='user_id'
).reset_index()
pivot_a["avg_pivot_a"]=\
pivot_a[True]/ \
(pivot_a[False]+pivot_a[False])
print(pivot_a)

percent_b=b_clicks.groupby(['is_click','day']).user_id.count().reset_index()

pivot_b=percent_b.pivot(
  columns="is_click",
  index="day",
  values="user_id"
).reset_index()


pivot_b["avg_pivot_b"]=\
pivot_b[True]/\
(pivot_b[True]+pivot_b[False])

print(pivot_b)






