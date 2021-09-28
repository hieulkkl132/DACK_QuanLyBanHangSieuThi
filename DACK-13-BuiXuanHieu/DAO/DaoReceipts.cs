using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DACK_13_BuiXuanHieu.DAO
{
    class DaoReceipts
    {
        SupermarketEntities supmar;
        public DaoReceipts()
        {
            supmar = new SupermarketEntities();
        }
        public dynamic loadTableReceipts()
        {
            //
            dynamic reciepts = supmar.Receipts.Select(s => new
            {
                s.ReceiptID,
                s.EmployeeID,
                s.CustomerID,
                s.ReceiveDate,
                s.ReceiveMethod
            }).ToList();

            return reciepts;
        }
        public bool addRecord(Receipt s)
        {
            //
            try
            {
                supmar.Receipts.Add(s);
                supmar.SaveChanges();
                return true;
            }
            catch //(Exception e)
            {
                //MessageBox.Show(e.Message.ToString());
                return false;
            }
        }
        public bool editRecord(Receipt newRecord)
        {
            //
            try
            {
                Receipt oldRecord = supmar.Receipts.First(s => s.ReceiptID == newRecord.ReceiptID);
                oldRecord.EmployeeID = newRecord.EmployeeID;
                oldRecord.CustomerID = newRecord.CustomerID;
                oldRecord.ReceiveDate = newRecord.ReceiveDate;
                oldRecord.ReceiveMethod = newRecord.ReceiveMethod;

                supmar.SaveChanges();
                return true;
            }
            catch //(Exception e)
            {
                //MessageBox.Show(e.Message.ToString());
                return false;
            }
        }
        public bool removeRecord(int ReceiptID)
        {
            //
            try
            {
                Receipt chosenRecord = supmar.Receipts.First(s => s.ReceiptID == ReceiptID);
                supmar.Receipts.Remove(chosenRecord);
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
