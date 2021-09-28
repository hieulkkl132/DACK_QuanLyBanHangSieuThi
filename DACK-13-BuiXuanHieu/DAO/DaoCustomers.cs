using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DACK_13_BuiXuanHieu.DAO
{
    class DaoCustomers
    {
        SupermarketEntities supmar;
        public DaoCustomers()
        {
            supmar = new SupermarketEntities();
        }


        public dynamic getListCustomer()
        {
            var list = supmar.Customers.Select(s => new
            {
                s.MemberID,
                s.LastName,
                s.FirstName,
                s.BirthDate,
                s.Address,
                s.City,
                s.District,
                s.Phone,
                s.Email,
                s.CustomerID,

            }).ToList();
            return list;
        }

        //
        public bool addRecord(Customer c)
        {
            //
            try
            {
                supmar.Customers.Add(c);
                supmar.SaveChanges();
                return true;
            }
            catch //(Exception e)
            {
                //MessageBox.Show(e.Message.ToString());
                return false;
            }
        }

        //
        public bool editRecord(Customer newRecord)
        {
            //
            try
            {
                Customer oldRecord = supmar.Customers.First(s => s.CustomerID == newRecord.CustomerID);
                oldRecord.LastName = newRecord.LastName;
                oldRecord.FirstName = newRecord.FirstName;
                oldRecord.BirthDate = newRecord.BirthDate;
                oldRecord.Address = newRecord.Address;
                oldRecord.City = newRecord.City;
                oldRecord.District = newRecord.District;
                oldRecord.Phone = newRecord.Phone;
                oldRecord.Email = newRecord.Email;

                supmar.SaveChanges();
                return true;
            }
            catch //(Exception e)
            {
                return false;
                //throw;
            }
        }

        //
        public bool removeRecord(int customerID)
        {
            try
            {
                Customer chosenRecord = supmar.Customers.First(s => s.CustomerID == customerID);
                supmar.Customers.Remove(chosenRecord);
                supmar.SaveChanges();
                return true;

            }
            catch //(Exception)
            {
                return false;
                //throw;
            }
        }

 //MEMBER//

        public dynamic getMemberList()
        {
            var list = supmar.Members.Select(s => new
            {
                s.MemberID,
                s.JoinDate,
                s.Rank,
                s.Point,
            }).ToList();
            return list;
        }

        public bool assignMember(int customerID, Member member)
        {          
            try
            {
                Customer customer = supmar.Customers.First(s => s.CustomerID == customerID);
                customer.Member = member;
                supmar.SaveChanges();
            }
            catch //(Exception e)
            {               
                return false;
            }
            return true;
        }

        public Member loadMemberByID(int memberID)
        {           
            Member member = supmar.Members.First(m => m.MemberID == memberID);
            return member;
        }
    }
}
