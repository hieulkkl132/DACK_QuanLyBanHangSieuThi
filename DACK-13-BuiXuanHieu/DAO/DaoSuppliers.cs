using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DACK_13_BuiXuanHieu.DAO
{
    class DaoSuppliers
    {
        //
        SupermarketEntities supmar;

        //
        public DaoSuppliers()
        {
            supmar = new SupermarketEntities();
        }

        public dynamic loadTableSuppliers()
        {
            //
            dynamic suppliers = supmar.Suppliers.Select(s => new
            {
                s.SupplierID,
                s.CompanyName,
                s.Contact,
                s.ContactTitle,
                s.Address,
                s.City,
                s.District,
                s.Phone,
                s.Fax
            }).ToList();

            return suppliers;
        }

        public bool addRecord(Supplier s)
        {
            //
            try
            {
                supmar.Suppliers.Add(s);
                supmar.SaveChanges();
                return true;
            }
            catch //(Exception e)
            {
                //MessageBox.Show(e.Message.ToString());
                return false;
            }
        }

        public bool editRecord(Supplier newRecord)
        {
            //
            try
            {
                Supplier oldRecord = supmar.Suppliers.First(s => s.SupplierID == newRecord.SupplierID);
                oldRecord.CompanyName = newRecord.CompanyName;
                oldRecord.Contact = newRecord.Contact;
                oldRecord.ContactTitle = newRecord.ContactTitle;
                oldRecord.Address = newRecord.Address;
                oldRecord.City = newRecord.City;
                oldRecord.District = newRecord.District;
                oldRecord.Phone = newRecord.Phone;
                oldRecord.Fax = newRecord.Fax;

                supmar.SaveChanges();
                return true;
            }
            catch //(Exception e)
            {
                //MessageBox.Show(e.Message.ToString());
                return false;
            }
        }

        public bool removeRecord(int supplierID)
        {
            //
            try
            {
                Supplier chosenRecord = supmar.Suppliers.First(s => s.SupplierID == supplierID);
                supmar.Suppliers.Remove(chosenRecord);
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
