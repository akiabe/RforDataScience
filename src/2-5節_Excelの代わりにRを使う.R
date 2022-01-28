library(gapminder)
library(tidyverse)

gapminder

# データ全体をビューワーで見る
gapminder %>% 
  View()

### フィルタ　###

# continentの列がAsiaのデータを抽出する
gapminder %>% 
  filter(continent == "Asia")

# country列がJapanのデータを抽出する
gapminder %>% 
  filter(country == "Japan")

# Japan以外のデータを抽出する
gapminder %>% 
  filter(country != "Japan")

# Japan、かつyearの値が1982以上のデータを抽出する
gapminder %>% 
  filter(country == "Japan", year >= 1982)

# Japanの1990年代のデータを抽出する
gapminder %>% 
  filter(country == "Japan", year >= 1990, year < 2000)

# Japanの1997年、または2007年のデータを抽出する
gapminder %>% 
  filter(country == "Japan", year == 1997 | year == 2007)

### 並び替え ###

gap2007 <- gapminder %>% 
  filter(year == 2007)
gap2007

# popの昇順に並び替える
gap2007 %>% 
  arrange(pop)

# popの降順に並び替える
gap2007 %>% 
  arrange(desc(pop))

# 並び替えるカラムを複数指定する場合
gap2007 %>% 
  arrange(continent, country, desc(year))

### 集計 ###

1:10 %>% 
  sum()

asia2007 <- gapminder %>% 
  filter(continent == "Asia", year == 2007)
asia2007

# popの合計を計算する
asia2007 %>% 
  summarise(sum(pop))

asia2007 %>% 
  summarise(total_pop = sum(pop)) # 集計結果に名前を付ける場合

# popの最大値、最小値を求める場合
asia2007 %>% 
  summarise(max(pop), min(pop))

# 2007年のcontinentごとの国の数とpopの合計を集計したい場合
gap2007 %>% 
  group_by(continent) %>% 
  summarise(n = n(), total_pop = sum(pop))

# 1990年以降のデータのうち、continentごと、さらにyearごとのpopの合計を集計したい場合
gapminder %>% 
  filter(year >= 1990) %>% 
  group_by(continent, year) %>% 
  summarise(total_pop = sum(pop))

### データの結合 ###

orders <- tibble(item_id = c(3, 1, 2))
items <- tibble(item_id = 1:4, price = c(200, 300, 600, 400))
orders
items

# ordersとitemsを結合する場合
orders %>% 
  left_join(items, by = "item_id")

# 2つのテーブルでキーとするカラム名が異なる場合
orders <- tibble(item_id = c(3, 1, 2))
items <- tibble(id = 1:4, price = c(200, 300, 600, 400))
orders %>% 
  left_join(items, by = c("item_id" = "id"))

# left_join( )で左のテーブルの行をすべて含める場合
x <- tibble(key = c(1, 2, 3), value_x = c(10, 20, 30))
y <- tibble(key = c(1, 2, 4), value_y = c(100, 200, 400))
left_join(x, y)

# right_join( )で右のテーブルの行をすべて含める場合
right_join(x, y)

# inner_join( )で右と左のテーブル両方にキーがある行のみ返す場合
inner_join(x, y)
