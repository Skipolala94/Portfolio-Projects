select*
from [Sql Project portfolio]..[NashvilleHousing ]

select SaleDate, convert(date, saledate)
from [Sql Project portfolio]..[NashvilleHousing ]

update [NashvilleHousing ]
set SaleDate = convert(Date, Saledate)

Alter Table [NashvilleHousing]
Add SaleDateConverted Date;

update [NashvilleHousing ]
set SaleDateConverted = convert(Date, Saledate)

select SaleDateConverted, convert(date, SaleDate)
from [Sql Project portfolio]..[NashvilleHousing ]


select*
from [Sql Project portfolio]..[NashvilleHousing ]
--where propertyaddress is null
order by ParcelID

select a.ParcelID, a.propertyaddress, b.parcelID, b.propertyaddress, isnull(a.propertyaddress, b.propertyaddress)
from [Sql Project portfolio]..[NashvilleHousing ] a
join [Sql Project portfolio]..[NashvilleHousing ] b
    on a.parcelId = b.parcelID
	and a.[uniqueID] <> b.[uniqueID]
where a.propertyaddress is null

update a
set propertyAddress = isnull(a.propertyaddress, b.propertyaddress)
from [Sql Project portfolio]..[NashvilleHousing ] a
join [Sql Project portfolio]..[NashvilleHousing ] b
    on a.parcelId = b.parcelID
	and a.[uniqueID] <> b.[uniqueID]


	select propertyaddress
	from [Sql Project portfolio]..[NashvilleHousing ]
	order by parcelID

select
SUBSTRING(PropertyAddress, 1, charindex(',', propertyaddress)-1) Address
from [Sql Project portfolio]..[NashvilleHousing ]

select
SUBSTRING(PropertyAddress, 1, charindex(',', propertyaddress)-1) as Address
, SUBSTRING(PropertyAddress, charindex(',', propertyaddress) +1, len(propertyaddress)) as Address
from [Sql Project portfolio]..[NashvilleHousing ]



ALTER TABLE [NashvilleHousing]
Add PropertySplitAddress Nvarchar(255);

Update [NashvilleHousing]
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE [NashvilleHousing]
Add PropertySplitCity Nvarchar(255);

Update [NashvilleHousing]
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))




--Select
--PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
--,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
--,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
--From From [Sql Project portfolio]..[NashvilleHousing ]



--ALTER TABLE [NashvilleHousing]
--Add OwnerSplitAddress Nvarchar(255);

--Update NashvilleHousing
--SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


--ALTER TABLE [NashvilleHousing]
--Add OwnerSplitCity Nvarchar(255);

--Update [NashvilleHousing]
--SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



--ALTER TABLE [NashvilleHousing]
--Add OwnerSplitState Nvarchar(255);

--Update NashvilleHousing
--SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)



--Select *
--From From [Sql Project portfolio]..[NashvilleHousing ]



Select *
From [Sql Project portfolio]..[NashvilleHousing ]

Select Distinct (SoldAsVacant), count(SoldAsVacant)
From [Sql Project portfolio]..[NashvilleHousing ]
group by  SoldAsVacant 
order by 2

select SoldAsVacant
, case when SoldAsVacant = 'Y' Then 'Yes'
       when SoldAsVacant = 'N' Then 'No'
	   Else SoldAsVacant
	   End
From [Sql Project portfolio]..[NashvilleHousing ]





update [NashvilleHousing ]
set SoldAsVacant = case when SoldAsVacant = 'Y' Then 'Yes'
       when SoldAsVacant = 'N' Then 'No'
	   Else SoldAsVacant
	   End


with RowNumCTE as(
select*,
     row_number() over (
	 partition by ParcelID,
	              PropertyAddress,
				  SalePrice,
				  SaleDate,
				  LegalReference
				  order by
				     UniqueID
					  ) row_num

from [Sql Project portfolio]..[NashvilleHousing ]
--order by ParcelID
)
Delete
from RowNumCTE 
where row_num > 1
--order by PropertyAddress


select*
from [Sql Project portfolio]..[NashvilleHousing ]


Alter table [Sql Project portfolio]..[NashvilleHousing ]
drop column ownerAddress, TaxDistrict, PropertyAddress

Alter table [Sql Project portfolio]..[NashvilleHousing ]
drop column saledate