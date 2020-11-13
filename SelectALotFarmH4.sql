
/*Show what i mean are the importing infomation from the test dataset
and to make sure the constrints works..
This is autogenerote i SQL Server Management Studio.
*/
SELECT Owner.First, Owner.Last, Owner.CVR, Owner_Phone.Phone, Farm.Name, Farm.Streetname, Farm_ChrNo.ChrNo, Box.Type, Box.Stall_No, State.Id, State.Severity, Changes.Time, Changes.Serialnumber, 
                         Changes.Id AS Changes_id, Lives_In.MoveInTime, Lives_In.No, Lives_In.Stall_No AS Stall_Lives_IN, Lives_In.Pnumber, Lives_In.ChrNo AS ChrNo_Lives_IN, Lives_In.Color, Lives_In.Id AS Lives_In_id, 
                         Animal.ChrNo AS Animal_ChrNo, Animal.Color AS Animale_Color, Animal.Id AS Animal_id, Animal.Sex, Animal.Type AS Animal_Type, Animal.Birth, Animal.Age, SmartUnit.Type AS Smart_Unit_Type, SmartUnit.IpAddress, 
                         SmartUnit.MacAddress, SmartUnit.Serialnumber AS Smart_Unit_SerialNumber, Box_monitor.Value, Box_monitor.Stall_No AS Box_Mon_Stall_No, Box_monitor.No AS Box_Monitor_No, Box_monitor.Time AS Box_Monitor_Time, 
                         Box.Outdoor
FROM Box_monitor FULL JOIN
                         Box ON Box_monitor.No = Box.No AND Box_monitor.Stall_No = Box.Stall_No AND Box_monitor.Pnumber = Box.Pnumber FULL JOIN
                         Changes ON Box_monitor.Serialnumber = Changes.Serialnumber FULL JOIN
                         Farm ON Box_monitor.Pnumber = Farm.Pnumber FULL JOIN
                         Farm_ChrNo ON Farm.Pnumber = Farm_ChrNo.Pnumber FULL JOIN
                         Lives_In ON Box.No = Lives_In.No AND Box.Stall_No = Lives_In.Stall_No AND Box.Pnumber = Lives_In.Pnumber FULL JOIN
                         Animal ON Lives_In.ChrNo = Animal.ChrNo AND Lives_In.Color = Animal.Color AND Lives_In.Id = Animal.Id FULL JOIN
                         Owner ON Farm.CVR = Owner.CVR FULL JOIN
                         Owner_Phone ON Owner.CVR = Owner_Phone.CVR FULL JOIN
                         SmartUnit ON Box_monitor.Serialnumber = SmartUnit.Serialnumber AND Changes.Serialnumber = SmartUnit.Serialnumber FULL JOIN
                         Stall ON Box.Stall_No = Stall.No AND Box.Pnumber = Stall.Pnumber AND Farm.Pnumber = Stall.Pnumber FULL JOIN
                         Stall_monitor ON SmartUnit.Serialnumber = Stall_monitor.Serialnumber AND Stall.No = Stall_monitor.No AND Stall.Pnumber = Stall_monitor.Pnumber FULL JOIN
                         State ON Changes.Id = State.Id