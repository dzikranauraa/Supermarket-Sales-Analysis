# Tampilkan 10 data pertama dari tabel
select*from `sql-portofolio-476706.retail.supermarket sales` limit 10;

# Hitung jumlah total transaksi
select count (*) `total transaksi`
from `sql-portofolio-476706.retail.supermarket sales`;

# Tampilkan daftar product line
select  distinct `product line`
from `sql-portofolio-476706.retail.supermarket sales` ;

# Banyak setiap rating
select rating, count (rating) as banyak_rating
from `sql-portofolio-476706.retail.supermarket sales`
group by 1 order by 1 asc;

# rata-rata rating dari setiap branch
select branch, avg (rating) avg_rating
from `sql-portofolio-476706.retail.supermarket sales`
group by 1;

# total revenue per branch
select branch, sum(total)
from `sql-portofolio-476706.retail.supermarket sales`
group by 1;

# rata-rata total belanja per payment method.
select payment, avg (total)
from `sql-portofolio-476706.retail.supermarket sales`
group by 1;

# customer type
select `customer type` ,count(*) from `sql-portofolio-476706.retail.supermarket sales`
group by 1;

# apakah customer type tertentu (Member vs Normal) memiliki average spending lebih tinggi
select `customer type` as tipe_cust, ROUND(AVG(Total), 2) avg_spend
from `sql-portofolio-476706.retail.supermarket sales`
group by 1;

# total revenue per product line
select `product line`, sum (`total`) total_revenue
from `sql-portofolio-476706.retail.supermarket sales`
group by 1 order by 2 desc;

# jumlah transaksi per city dan branch
select city, branch, count (`invoice id`) as `jumlah transaksi `
from `sql-portofolio-476706.retail.supermarket sales`
group by  1;

# product line yang total revenue-nya lebih dari 50.000.
select `product line`, sum(`total`) as `total revenue`
from `sql-portofolio-476706.retail.supermarket sales`
group by 1
having sum(`total`) > 50000;

# jumlah transaksi per bulan
select extract (month from `date`) bulan, count(*) as jumlah_transaksi
from `sql-portofolio-476706.retail.supermarket sales`
group by 1 order by 1;

# top 3 product line penyumbang revenue tertinggi di setiap city?
select city, product_line, total_reve
from (
  select
    City, `Product line` product_line, sum(`total`) total_rev,
    ROW_NUMBER() OVER (PARTITION by City order by SUM(`gross income`) desc) rank
  from `sql-portofolio-476706.retail.supermarket sales`
  group by City, product_line
)
where rank <= 3
order by City, total_revenue desc;
