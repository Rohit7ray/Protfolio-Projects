use PortfolioProject

---------------CLEANING DATA USING SQL QUERIES---------------
--1.Inserting data using bulk insert
--drop table dbo.Housing_Data
CREATE TABLE dbo.Housing_Data (
    UniqueID NVARCHAR(50),
    ParcelID NVARCHAR(50),
    LandUse NVARCHAR(100),
    PropertyAddress NVARCHAR(255),
    SaleDate NVARCHAR(50),
    SalePrice NVARCHAR(50),
    LegalReference NVARCHAR(50),
    SoldAsVacant NVARCHAR(50),
    OwnerName NVARCHAR(255),
    OwnerAddress NVARCHAR(255),
    Acreage NVARCHAR(100),
    TaxDistrict NVARCHAR(100),
    LandValue NVARCHAR(50),
    BuildingValue NVARCHAR(50),
    TotalValue NVARCHAR(50),
    YearBuilt NVARCHAR(50),
    Bedrooms NVARCHAR(50),
    FullBath NVARCHAR(50),
    HalfBath NVARCHAR(100)
);

BULK insert Housing_Data
from  'E:\UK Personal\Project\Data\Housing_data.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FORMAT = 'CSV',
    FIELDQUOTE = '"'
);

select * from Housing_Data



--2.Standardize Date Format
select saleDate, convert(Date,SaleDate)
from Housing_Data

update Housing_Data
set SaleDate = Convert(Date, SaleDate)


--3. Populate Property Address Data
select * from Housing_Data
select a.ParcelID, a.PropertyAddress,b.PropertyAddress, isnull(a.PropertyAddress,b.PropertyAddress)
from Housing_Data a join Housing_Data b
on a.ParcelID = b.ParcelID
and a.UniqueID<>b.UniqueID
where a.PropertyAddress is nuLL


update a
set PropertyAddress = isnull(a.PropertyAddress,b.PropertyAddress)
from Housing_Data a join Housing_Data b
on a.ParcelID = b.ParcelID
and a.UniqueID<>b.UniqueID
where a.PropertyAddress is nuLL

--4.Breaking out address into individual columns (Address, City, State)
--PropertyAddress Column
select PropertyAddress from Housing_Data

select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, Len(PropertyAddress)) as City
from Housing_Data

Alter table Housing_data
add Address  NVarchar(max)
,City nvarchar(max)

Update Housing_Data
set Address = SUBSTRING(PropertyAddress, 1 , charindex(',',PropertyAddress)-1)
,City = SUBSTRING(PropertyAddress, charindex(',',PropertyAddress)+1,  len(PropertyAddress))

select * from Housing_Data

exec sp_rename 'Housing_data.Address', 'Property_Address', 'COLUMN'
exec sp_rename 'Housing_data.City', 'Property_City', 'COLUMN'

--OwnerAddress Column
Select * from Housing_Data

select
PARSENAME(Replace(OwnerAddress,',','.'),3),
PARSENAME(Replace(OwnerAddress,',','.'),2),
PARSENAME(Replace(OwnerAddress,',','.'),1)
from Housing_Data



Alter table Housing_data
Add Owner_Address Nvarchar(max),
Owner_City Nvarchar(max),
Owner_State Nvarchar(max)

Update Housing_Data
set Owner_Address = PARSENAME(Replace(OwnerAddress,',','.'),3),
Owner_City = PARSENAME(Replace(OwnerAddress,',','.'),2),
Owner_State = PARSENAME(Replace(OwnerAddress,',','.'),1)

select * from Housing_Data


--5. Change Y and N to Yes and No in "SoldAsVacant" column
select Distinct(SoldAsVacant) from Housing_Data

select Distinct(SoldAsVacant), Count(SoldAsVacant) from Housing_Data group by SoldAsVacant

select 
Case when SoldAsVacant = 'Y' then 'Yes'
	 when SoldAsVacant = 'N' then 'No'
	 ELSE SoldAsVacant
END
from Housing_Data


update Housing_Data
set SoldAsVacant = Case when SoldAsVacant = 'Y' then 'Yes'
	 when SoldAsVacant = 'N' then 'No'
	 ELSE SoldAsVacant
END


select Distinct(SoldAsVacant), Count(SoldAsVacant) from Housing_Data group by SoldAsVacant


--6.Remove Duplicates
with ROWNUMCTE as(
select *, 
ROW_NUMBER() over (Partition by ParcelID, PropertyAddress, SaleDate, SalePrice, legalReference order by UniqueID) row_num
From 
Housing_Data
--order by row_num
)
delete from ROWNUMCTE 
where row_num >1



with ROWNUMCTE as(
select *, 
ROW_NUMBER() over (Partition by ParcelID, PropertyAddress, SaleDate, SalePrice, legalReference order by UniqueID) row_num
From 
Housing_Data
--order by row_num
)
Select * from ROWNUMCTE 
where row_num >1


select * from Housing_Data

--7. Deleting unused columns

ALter table Housing_data
drop column OwnerAddress, PropertyAddress, TaxDistrict

select* from Housing_Data