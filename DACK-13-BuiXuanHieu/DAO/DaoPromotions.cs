using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DACK_13_BuiXuanHieu.DAO
{
    class DaoPromotions
    {
        SupermarketEntities supmar;
        public DaoPromotions()
        {
            supmar = new SupermarketEntities();
        }
        public dynamic loadTablePromotions()
        {
            dynamic promotions = supmar.Promotions.Select(s => new
            {
                s.PromotionID,
                s.PromotionName,
                s.Description
            }).ToList();

            return promotions;
        }
        public bool addRecord(Promotion s)
        {
            try
            {
                supmar.Promotions.Add(s);
                supmar.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }
        public bool editRecord(Promotion newRecord)
        {
            try
            {
                Promotion oldRecord = supmar.Promotions.First(s => s.PromotionID == newRecord.PromotionID);
                oldRecord.PromotionName = newRecord.PromotionName;
                oldRecord.Description = newRecord.Description;


                supmar.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }
        public bool Check(Promotion d)
        {
            Promotion o = supmar.Promotions.Find(d.PromotionID);
            if (d != null)
            {
                return true;
            }
            else
                return false;
        }
        public bool removeRecord(Promotion p)
        {
            int? sl;
            sl = supmar.DPromotion(p.PromotionID).FirstOrDefault();
            supmar.SaveChanges();
            if (sl != 0)

                return true;
            else
                return false;

        }
    }
}
