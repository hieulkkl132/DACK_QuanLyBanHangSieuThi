using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DACK_13_BuiXuanHieu.DAO
{
    class DaoEvents
    {
        SupermarketEntities supmar;
        public DaoEvents()
        {
            supmar = new SupermarketEntities();
        }
        public dynamic loadTableEvents()
        {
            dynamic suppliers = supmar.Events.Select(s => new
            {
                s.ProductID,
                s.Promotion.PromotionName,
                s.Product.ProductName,
                s.StartDate,
                s.EndDate,
                s.LimitQuantity,
                s.Discount,
                s.Description
            }).ToList();

            return suppliers;
        }
        public dynamic loadComboboxPromotions()
        {
            var ds = supmar.Promotions.Select(s => new
            {
                s.PromotionID,
                s.PromotionName
            }).ToList();
            return ds;
        }
        public dynamic loadComboboxProduct()
        {
            var ds2 = supmar.Products.Select(s => new
            {
                s.ProductID,
                s.ProductName
            }).ToList();
            return ds2;
        }
        public bool addRecord(Event s)
        {
            try
            {
                supmar.Events.Add(s);
                supmar.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }
        public bool editRecord(Event newRecord)
        {
            try
            {
                Event oldRecord = supmar.Events.Find(newRecord.PromotionID, newRecord.ProductID, newRecord.StartDate);
                oldRecord.ProductID = newRecord.ProductID;
                oldRecord.StartDate = newRecord.StartDate;
                oldRecord.EndDate = newRecord.EndDate;
                oldRecord.LimitQuantity = newRecord.LimitQuantity;
                oldRecord.Discount = newRecord.Discount;
                oldRecord.Description = newRecord.Description;

                supmar.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }
        public bool removeRecord(Event d)
        {
            try
            {
                Event chosenRecord = supmar.Events.Find(d.PromotionID, d.ProductID, d.StartDate);
                supmar.Events.Remove(chosenRecord);
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

