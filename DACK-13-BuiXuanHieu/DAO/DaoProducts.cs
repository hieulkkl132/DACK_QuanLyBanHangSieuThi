using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DACK_13_BuiXuanHieu.DAO
{
    class DaoProducts
    {
        SupermarketEntities supmar;

        public DaoProducts()
        {
            supmar = new SupermarketEntities();
        }

        public dynamic loadTableProduct()
        {
            var ds = supmar.Products.Select(s => new
            {
                s.ProductID,
                s.ProductName,
                s.Category.CategoryName,
                s.QuantityPerUnit,
                s.UnitPrice,
                s.UnitsInStock,
                s.Active
            }).ToList();
            return ds;
        }
        public List<Product> LoadListProducts()
        {
            var ds = supmar.Products.Select(s => s).ToList();

            return ds;
        }

        public dynamic loadComboboxCategory()
        {
            var ds = supmar.Categories.Select(s => new
            {
                s.CategoryID,
                s.CategoryName
            }).ToList();
            return ds;
        }

        public bool addRecord(Product p)
        {
            try
            {
                supmar.Products.Add(p);
                supmar.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        public bool editRecord(Product newRecord)
        {
            try
            {
                Product oldRecord = supmar.Products.First(s => s.ProductID == newRecord.ProductID);
                oldRecord.ProductName = newRecord.ProductName;
                oldRecord.CategoryID = newRecord.CategoryID;
                oldRecord.QuantityPerUnit = newRecord.QuantityPerUnit;
                oldRecord.UnitPrice = newRecord.UnitPrice;
                oldRecord.UnitsInStock = newRecord.UnitsInStock;
                oldRecord.Active = newRecord.Active;
                supmar.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        public bool removeRecord(int ProductID)
        {
            try
            {
                Product chosenRecord = supmar.Products.First(s => s.ProductID == ProductID);
                supmar.Products.Remove(chosenRecord);
                supmar.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }
    }
}
