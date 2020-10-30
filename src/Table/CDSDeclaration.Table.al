table 60001 "CDS new_Declaration"
{
  ExternalName = 'new_declaration';
  TableType = CDS;
  Description = '';

  fields
  {
    field(1;new_DeclarationId;GUID)
    {
      ExternalName = 'new_declarationid';
      ExternalType = 'Uniqueidentifier';
      ExternalAccess = Insert;
      Description = 'Unieke id van entiteitsexemplaren';
      Caption = 'Declaration';
    }
    field(2;CreatedOn;Datetime)
    {
      ExternalName = 'createdon';
      ExternalType = 'DateTime';
      ExternalAccess = Read;
      Description = 'Datum en tijdstip waarop de record is gemaakt.';
      Caption = 'Gemaakt op';
    }
    field(3;CreatedBy;GUID)
    {
      ExternalName = 'createdby';
      ExternalType = 'Lookup';
      ExternalAccess = Read;
      Description = 'De unieke id van de gebruiker die de record heeft gemaakt.';
      Caption = 'Gemaakt door';
      TableRelation = "CRM Systemuser".SystemUserId;
    }
    field(4;ModifiedOn;Datetime)
    {
      ExternalName = 'modifiedon';
      ExternalType = 'DateTime';
      ExternalAccess = Read;
      Description = 'Datum en tijdstip waarop de record is gewijzigd.';
      Caption = 'Gewijzigd op';
    }
    field(5;ModifiedBy;GUID)
    {
      ExternalName = 'modifiedby';
      ExternalType = 'Lookup';
      ExternalAccess = Read;
      Description = 'De unieke id van de gebruiker die de record heeft gewijzigd.';
      Caption = 'Gewijzigd door';
      TableRelation = "CRM Systemuser".SystemUserId;
    }
    field(6;CreatedOnBehalfBy;GUID)
    {
      ExternalName = 'createdonbehalfby';
      ExternalType = 'Lookup';
      ExternalAccess = Read;
      Description = 'De unieke id van de gemachtigde gebruiker die de record heeft gemaakt.';
      Caption = 'Gemaakt door (gemachtigde)';
      TableRelation = "CRM Systemuser".SystemUserId;
    }
    field(7;ModifiedOnBehalfBy;GUID)
    {
      ExternalName = 'modifiedonbehalfby';
      ExternalType = 'Lookup';
      ExternalAccess = Read;
      Description = 'De unieke id van de gemachtigde gebruiker die de record heeft gewijzigd.';
      Caption = 'Gewijzigd door (gemachtigde)';
      TableRelation = "CRM Systemuser".SystemUserId;
    }
    field(16;OwnerId;GUID)
    {
      ExternalName = 'ownerid';
      ExternalType = 'Owner';
      Description = 'Eigenaar-id';
      Caption = 'Eigenaar';
    }
    field(21;OwningBusinessUnit;GUID)
    {
      ExternalName = 'owningbusinessunit';
      ExternalType = 'Lookup';
      ExternalAccess = Read;
      Description = 'De unieke id van de bedrijfseenheid die eigenaar van de record is';
      Caption = 'Business unit die eigenaar is';
      TableRelation = "CRM Businessunit".BusinessUnitId;
    }
    field(22;OwningUser;GUID)
    {
      ExternalName = 'owninguser';
      ExternalType = 'Lookup';
      ExternalAccess = Read;
      Description = 'Unieke id van de gebruiker die eigenaar is van de record.';
      Caption = 'Gebruiker die eigenaar is';
      TableRelation = "CRM Systemuser".SystemUserId;
    }
    field(23;OwningTeam;GUID)
    {
      ExternalName = 'owningteam';
      ExternalType = 'Lookup';
      ExternalAccess = Read;
      Description = 'De unieke id van het team dat eigenaar is van de record.';
      Caption = 'Team dat eigenaar is';
      TableRelation = "CRM Team".TeamId;
    }
    field(24;statecode;Option)
    {
      ExternalName = 'statecode';
      ExternalType = 'State';
      ExternalAccess = Modify;
      Description = 'Status van de/het Declaration';
      Caption = 'Status';
      InitValue = " ";
      OptionMembers = " ", Actief, Inactief;
      OptionOrdinalValues = -1, 0, 1;
    }
    field(26;statuscode;Option)
    {
      ExternalName = 'statuscode';
      ExternalType = 'Status';
      Description = 'De reden van de status van de Declaration';
      Caption = 'Reden van status';
      InitValue = " ";
      OptionMembers = " ", Actief, Inactief;
      OptionOrdinalValues = -1, 1, 2;
    }
    field(28;VersionNumber;BigInteger)
    {
      ExternalName = 'versionnumber';
      ExternalType = 'BigInt';
      ExternalAccess = Read;
      Description = 'Versienummer';
      Caption = 'Versienummer';
    }
    field(29;ImportSequenceNumber;Integer)
    {
      ExternalName = 'importsequencenumber';
      ExternalType = 'Integer';
      ExternalAccess = Insert;
      Description = 'Volgnummer van de import waarmee deze record is gemaakt.';
      Caption = 'Volgnummer van de importbewerking';
    }
    field(30;OverriddenCreatedOn;Date)
    {
      ExternalName = 'overriddencreatedon';
      ExternalType = 'DateTime';
      ExternalAccess = Insert;
      Description = 'Datum en tijdstip waarop de record is gemigreerd.';
      Caption = 'Record is gemaakt op';
    }
    field(31;TimeZoneRuleVersionNumber;Integer)
    {
      ExternalName = 'timezoneruleversionnumber';
      ExternalType = 'Integer';
      Description = 'Alleen voor intern gebruik.';
      Caption = 'Versienummer van tijdzoneregel';
    }
    field(32;UTCConversionTimeZoneCode;Integer)
    {
      ExternalName = 'utcconversiontimezonecode';
      ExternalType = 'Integer';
      Description = 'Tijdzonecode die werd gebruikt toen de record werd gemaakt.';
      Caption = 'Tijdzonecode voor UTC-conversie';
    }
    field(33;new_No;Text[100])
    {
      ExternalName = 'new_no';
      ExternalType = 'String';
      Description = 'Required name field';
      Caption = 'No';
    }
    field(34;new_ApprovedDate;Date)
    {
      ExternalName = 'new_approveddate';
      ExternalType = 'DateTime';
      Description = '';
      Caption = 'Approved Date';
    }
    field(35;new_ApprovedBy;Text[100])
    {
      ExternalName = 'new_approvedby';
      ExternalType = 'String';
      Description = '';
      Caption = 'Approved By';
    }
    field(36;new_ManagerEmail;Text[100])
    {
      ExternalName = 'new_manageremail';
      ExternalType = 'String';
      Description = '';
      Caption = 'Manager E-mail';
    }
    field(37;new_EmployeeNo;Text[100])
    {
      ExternalName = 'new_employeeno';
      ExternalType = 'String';
      Description = '';
      Caption = 'Employee No';
    }
    field(38;new_AccountNo;Text[100])
    {
      ExternalName = 'new_accountno';
      ExternalType = 'String';
      Description = '';
      Caption = 'Account No';
    }
    field(39;new_EmployeeEmail;Text[100])
    {
      ExternalName = 'new_employeeemail';
      ExternalType = 'String';
      Description = '';
      Caption = 'Employee E-mail';
    }
    field(40;new_ManagerNo;Text[100])
    {
      ExternalName = 'new_managerno';
      ExternalType = 'String';
      Description = '';
      Caption = 'Manager No';
    }
    field(41;new_Approved;Boolean)
    {
      ExternalName = 'new_approved';
      ExternalType = 'Boolean';
      Description = '';
      Caption = 'Approved';
    }
    field(43;new_Amount;Decimal)
    {
      ExternalName = 'new_amount';
      ExternalType = 'Decimal';
      Description = '';
      Caption = 'Amount';
    }
    field(44;new_Description;Text[100])
    {
      ExternalName = 'new_description';
      ExternalType = 'String';
      Description = '';
      Caption = 'Description';
    }
    field(45;new_PictureId;GUID)
    {
      ExternalName = 'new_pictureid';
      ExternalType = 'Uniqueidentifier';
      ExternalAccess = Read;
    }
    field(49;new_Date;Date)
    {
      ExternalName = 'new_date';
      ExternalType = 'DateTime';
      Description = '';
      Caption = 'Date';
    }
  }
  keys
  {
    key(PK;new_DeclarationId)
    {
      Clustered = true;
    }
    key(Name;new_No)
    {
    }
  }
  fieldgroups
  {
    fieldgroup(Dropdown;new_No)
    {
    }
  }
}