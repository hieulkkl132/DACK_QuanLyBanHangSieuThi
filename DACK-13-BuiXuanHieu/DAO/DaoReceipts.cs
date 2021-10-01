using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

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
                s.Employee.FirstName,
                s.Customer.LastName,
                s.ReceiveDate,
                s.ReceiveMethod
            }).ToList();

            return reciepts;
        }

        public dynamic loadComboboxEmployee()
        {
            var ds = supmar.Employees.Select(s => new
            {
                s.EmployeeID,
                s.FirstName,
            }).ToList();
            return ds;
        }
        public dynamic loadComboboxCustomer()
        {
            var ds2 = supmar.Customers.Select(s => new
            {
                s.CustomerID,
                s.LastName,
            }).ToList();
            return ds2;
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
            catch (Exception e)
            {
                MessageBox.Show(e.Message.ToString());
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
            catch (Exception e)
            {
                MessageBox.Show(e.Message.ToString());
                return false;
            }
        }
        public bool removeRecord(Receipt p)
        {
            int? sl;
            sl = supmar.DReceipt(p.ReceiptID).FirstOrDefault();
            supmar.SaveChanges();
            if (sl != 0)

                return true;
            else
                return false;

        }

        ///////////////////// RECEIPT DETAILS /////////////////////////////

        public dynamic loadRDetails(int Rid)
        {
            var ds = supmar.ReceiptDetails.Where(s => s.ReceiptID == Rid)
                    .Select(s => new
                    {
                        s.ReceiptID,
                        s.ProductID,
                        s.UnitPrice,
                        s.Quantity
                    }).ToList();
            return ds;
        }

        public void EditRDetails(ReceiptDetail dh)
        {
            ReceiptDetail o = supmar.ReceiptDetails.Find(dh.ReceiptID, dh.ProductID);
            o.UnitPrice = dh.UnitPrice;
            o.Quantity = dh.Quantity;
            supmar.SaveChanges();
        }

        public void RemoveRDetails(ReceiptDetail dh)
        {
            ReceiptDetail o = supmar.ReceiptDetails.Find(dh.ReceiptID, dh.ProductID);
            supmar.ReceiptDetails.Remove(o);
            supmar.SaveChanges();
        }


        //////////////////// PRODUCT RECEIPTS /////////////////////////

        public Product loadPDetails(int maSP)
        {
            Product p = supmar.Products.Where(S => S.ProductID == maSP)
                                                .FirstOrDefault();
            return p;
        }

        public bool ProductCheck(ReceiptDetail d)
        {
            int? sl;
            sl = supmar.ProductCheck(d.ReceiptID, d.ProductID).FirstOrDefault();
            if (sl != 0)
                return false;
            else
                return true;
        }

        public void AddRDetails(ReceiptDetail d)
        {
            supmar.ReceiptDetails.Add(d);
            supmar.SaveChanges();
        }

        public dynamic loadPCategories()
        {
            var ds = supmar.Categories.Select(s => new { s.CategoryID, s.CategoryName }).ToList();
            return ds;
        }

        public dynamic loadListProduct()
        {
            var ds = supmar.Products.Select(s => new
            {
                s.ProductID,
                s.ProductName,
                s.UnitPrice,
                s.UnitsInStock,
                s.Category.CategoryName
            }
                ).ToList();
            return ds;
        }
    }
}
