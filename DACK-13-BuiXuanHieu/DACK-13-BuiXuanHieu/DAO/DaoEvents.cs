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

        //
        public DaoEvents()
        {
            supmar = new SupermarketEntities();
        }
        public dynamic loadTableEvents()
        {
            //
            dynamic suppliers = supmar.Events.Select(s => new
            {
               s.PromotionID,
               s.ProductID,
               s.StartDate,
               s.EndDate,
               s.LimitQuantity,
               s.Discount,
               s.Description
            }).ToList();

            return suppliers;
        }
        public dynamic cbProduct()
        {
            dynamic products = supmar.Products.Select(s => new
            {
                s.ProductID,
                s.ProductName
            }).ToList();
            return products;
        }
        public dynamic cbPromotion()
        {
            dynamic Promotions = supmar.Promotions.Select(s => new
            {
                s.PromotionID,
                s.PromotionName
            }).ToList();
            return Promotions;
        }
        public bool addRecord(Event s)
        {
            //
            try
            {
                supmar.Events.Add(s);
                supmar.SaveChanges();
                return true;
            }
            catch //(Exception e)
            {
                //MessageBox.Show(e.Message.ToString());
                return false;
            }
        }
        public bool editRecord(Event newRecord)
        {
            //
            try
            {
                Event oldRecord = supmar.Events.First(s => s.PromotionID == newRecord.PromotionID);
                oldRecord.ProductID = newRecord.ProductID;
                oldRecord.StartDate = newRecord.StartDate;
                oldRecord.EndDate = newRecord.EndDate;
                oldRecord.LimitQuantity = newRecord.LimitQuantity;
                oldRecord.Discount = newRecord.Discount;
                oldRecord.Description = newRecord.Description;

                supmar.SaveChanges();
                return true;
            }
            catch //(Exception e)
            {
                //MessageBox.Show(e.Message.ToString());
                return false;
            }
        }
        public bool removeRecord(int PromotionID)
        {
            //
            try
            {
                Event chosenRecord = supmar.Events.First(s => s.PromotionID == PromotionID);
                supmar.Events.Remove(chosenRecord);
                supmar.SaveChanges();
                return true;
            }
            catch //(Exception e)
            {
                //MessageBox.Show(e.Message.ToString());
                return false;
            }
        }
    }
}
