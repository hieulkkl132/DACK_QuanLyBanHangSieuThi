﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DACK_13_BuiXuanHieu.DAO
{
    class DaoEmployees
    {
        SupermarketEntities supmar;

        public DaoEmployees()
        {
            supmar = new SupermarketEntities();
        }

        public dynamic loadTableEmployees()
        {
            var ds = supmar.Employees.Select(s => new
            {
                s.EmployeeID,
                s.LastName,
                s.FirstName,
                s.Position.PositionName,
                s.BirthDate,
                s.Address,
                s.City,
                s.District,
                s.Phone,
                s.Email
            }).ToList();
            return ds;
        }
        public dynamic loadComboboxPositon()
        {
            var ds = supmar.Positions.Select(s => new
            {
                s.PositionID,
                s.PositionName
            }).ToList();
            return ds;
        }
        public bool addRecord(Employee e)
        {
            try
            {
                supmar.Employees.Add(e);
                supmar.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }
        public bool editRecord(Employee newRecord)
        {
            try
            {
                Employee oldRecord = supmar.Employees.First(s => s.EmployeeID == newRecord.EmployeeID);
                oldRecord.LastName = newRecord.LastName;
                oldRecord.FirstName = newRecord.FirstName;
                oldRecord.PositionID = newRecord.PositionID;
                oldRecord.BirthDate = newRecord.BirthDate;
                oldRecord.Address = newRecord.Address;
                oldRecord.City = newRecord.City;
                oldRecord.District = newRecord.District;
                oldRecord.Phone = newRecord.Phone;
                oldRecord.Email = newRecord.Email;
                supmar.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }
        public bool removeRecord(int EmployeeID)
        {
            try
            {
                Employee chosenRecord = supmar.Employees.First(s => s.EmployeeID == EmployeeID);
                supmar.Employees.Remove(chosenRecord);
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
