-- data cleaning
SELECT SaleDate
 FROM nashville_housing_portfolio.`nashville_housing_data`;
 
-- populate property address data

SELECT * 
FROM nashville_housing_portfolio.`nashville_housing_data`
-- where PropertyAddress is null
order by ParcelID ;

SELECT a.ParcelID, b.ParcelID, a.PropertyAddress, b.PropertyAddress, isnull(a.PropertyAddress),
 isnull(b.PropertyAddress)
FROM nashville_housing_portfolio.`nashville_housing_data ` as  a
 inner join nashville_housing_portfolio.`nashville_housing_data`  as b
on a.ParcelID = b.ParcelID
and a.uniqueid <> b.uniqueid;

select a.ParcelID, b.ParcelID, a.PropertyAddress, b.PropertyAddress
FROM nashville_housing_portfolio.`nashville_housing_data` as  a
 inner join nashville_housing_portfolio.`nashville_housing_data`  as b
on a.ParcelID = b.ParcelID
and a.uniqueid <> b.uniqueid
where a.PropertyAddress is null ;

------------------------------------------------------------------------------------------------------------------------
-- breaking out address into individual columns (Address, city, state)

select OwnerAddress
from nashville_housing_portfolio.`nashville_housing_data`;

select distinct SoldasVacant, count(SoldAsVacant)
from nashville_housing_portfolio.`nashville_housing_data`
group by SoldAsVacant
order by 2;

select SoldAsVacant, 
case when SoldAsVacant = 'Y' then 'Yes'
when SoldAsVacant = 'N' then 'No'
else SoldAsVacant end
from nashville_housing_portfolio.`nashville_housing_data`;

update nashville_housing_portfolio.`nashville_housing_data`
set  SoldAsVacant = case when  SoldAsVacant =  'Y' then 'Yes'
when SoldAsVacant = 'N' then 'No'
else SoldAsVacant end
where SoldAsVacant = 'Yes'; 	

--------------------------------------------------------------------------------------------------------------------------
-- remove duplicate 

SELECT  SaleDate, SalePrice, SoldAsVacant,
case when SalePrice > 1500000 then 'large'
when SalePrice > 1000000 then 'Medium'
else 'Small' end
as Sale_plus
 FROM nashville_housing_portfolio.`nashville_housing_data`
 order by 1,2 ;
 
 SELECT  SoldAsVacant,
case when SoldAsVacant  = 'Y' then 'Yes'
when SoldAsVacant = 'N' then 'No'
else SoldAsVacant end
as Sale_plus11
into pop_plus2
 FROM nashville_housing_portfolio.`nashville_housing_data`
 where SaleDate = 09/26/2016;
 
 -- remove duplicates
select *,
dense_rank() over ( partition by ParcelID, SaleDate, SalePrice, PropertyAddress, LegalReference order  by UniqueID) 
       as "rank"
from nashville_housing_portfolio.`nashville_housing_data`
order by ParcelID;

 select distinct ParcelID, SaleDate, PropertyAddress, LegalReference
 from nashville_housing_portfolio.`nashville_housing_data`;
 ----------------------------------------------------------------------------------------------------------------------
-- delete unused columns
alter table  nashville_housing_portfolio.`nashville_housing_data`
drop column TaxDistrict ,
drop column propertyAddress;
select *
from nashville_housing_portfolio.`nashville_housing_data`;

alter table nashville_housing_portfolio.`nashville_housing_data`
drop column SaleDate;

