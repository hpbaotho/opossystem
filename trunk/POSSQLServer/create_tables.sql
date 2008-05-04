
DROP TABLE Users;

CREATE TABLE Users (
id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,
FirstName VARCHAR(20) NOT NULL ,
MiddleName VARCHAR(30) NOT NULL ,
LastName VARCHAR(30) NOT NULL ,
id_UserGroup INTEGER NOT NULL CONSTRAINT fk_usergroup_users REFERENCES UserGroups(id)
);

DROP TABLE Roles;

CREATE TABLE Roles (
id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,
Name VARCHAR(20) NOT NULL ,
Description VARCHAR(255) NOT NULL 
);

DROP TABLE Permissions;

CREATE TABLE Permissions (
id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,
Name VARCHAR(20) NOT NULL ,
Description VARCHAR(255) NOT NULL 
);

DROP TABLE RolesPermissions;

CREATE TABLE RolesPermissions (
id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,
id_Permission INTEGER NOT NULL CONSTRAINT fk_permission_rolespermissions REFERENCES Permissions(id),
id_Role INTEGER NOT NULL CONSTRAINT fk_role_rolespermissions REFERENCES Roles(id)
);

DROP TABLE UserGroups;

CREATE TABLE UserGroups (
id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,
Name VARCHAR(20) NOT NULL ,
Description VARCHAR(255) NOT NULL
);

DROP TABLE UserAuthentication;

CREATE TABLE UserAuthentication (
id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,
id_User INTEGER NOT NULL CONSTRAINT fk_user_userauthentication REFERENCES Users(id),
PasswordHash VARCHAR(33) NOT NULL,
UNIQUE (id_User)
);

DROP TABLE UserGroupRoles;

CREATE TABLE UserGroupRoles (
id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,
id_UserGroup INTEGER NOT NULL CONSTRAINT fk_usergroup_usergrouproles REFERENCES UserGroup(id),
id_Role INTEGER NOT NULL CONSTRAINT fk_role_usergrouproles REFERENCES Role(id)
);

DROP TABLE Transactions;

CREATE TABLE Transactions (
id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,
executed TIMESTAMP NOT NULL ,
id_User INTEGER NOT NULL CONSTRAINT fk_user_transactions REFERENCES Users(id)
);

DROP TABLE TransChildren;

CREATE TABLE TransChildren (
id INTEGER PRIMARY KEY NOT NULL ,
quantity INTEGER NOT NULL ,
id_Transaction INTEGER NOT NULL CONSTRAINT fk_transaction_transchildren REFERENCES Transactions(id),
id_TransType INTEGER NOT NULL CONSTRAINT fk_transtype_transchildren REFERENCES TransTypes(id),
id_Sku INTEGER NOT NULL CONSTRAINT fk_sku_transchildren REFERENCES Skus(id)
);

DROP TABLE TransTypes;

CREATE TABLE TransTypes (
id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,
description TEXT(30) NOT NULL 
);

DROP TABLE Items;

CREATE TABLE Items (
id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,
name TEXT NOT NULL ,
description TEXT NOT NULL
);

DROP TABLE Inventory;

CREATE TABLE Inventory (
id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,
location TEXT NOT NULL ,
quantity INTEGER NOT NULL
);

DROP TABLE SkuTypes;

CREATE TABLE SkuTypes (
id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,
description TEXT NOT NULL
);

DROP TABLE Skus;

CREATE TABLE Skus (
id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,
price INTEGER NOT NULL ,
id_Item INTEGER NOT NULL CONSTRAINT fk_item_skus REFERENCES Items(id),
id_SkuType INTEGER NOT NULL CONSTRAINT fk_skutype_skus REFERENCES SkuTypes(id),
id_Inventory INTEGER NOT NULL CONSTRAINT fk_inventory_skus REFERENCES Inventory(id)
);

-- Constraints are enforced by triggers in SQLite, unfortunately. It is way too tedious to write
-- all of these by hand, so a generator was used and it looks really clean
-- See: http://www.rcs-comp.com/site/index.php/view/Utilities-SQLite_foreign_key_trigger_generator

-- Foreign Key Preventing insert
CREATE TRIGGER fki_Users_id_UserGroup_UserGroups_id
BEFORE INSERT ON [Users]
FOR EACH ROW BEGIN
  SELECT RAISE(ROLLBACK, 'insert on table "Users" violates foreign key constraint "fki_Users_id_UserGroup_UserGroups_id"')
  WHERE (SELECT id FROM UserGroups WHERE id = NEW.id_UserGroup) IS NULL;
END;

-- Foreign key preventing update
CREATE TRIGGER fku_Users_id_UserGroup_UserGroups_id
BEFORE UPDATE ON [Users]
FOR EACH ROW BEGIN
    SELECT RAISE(ROLLBACK, 'update on table "Users" violates foreign key constraint "fku_Users_id_UserGroup_UserGroups_id"')
      WHERE (SELECT id FROM UserGroups WHERE id = NEW.id_UserGroup) IS NULL;
END;

-- Foreign key preventing delete
CREATE TRIGGER fkd_Users_id_UserGroup_UserGroups_id
BEFORE DELETE ON UserGroups
FOR EACH ROW BEGIN
  SELECT RAISE(ROLLBACK, 'delete on table "UserGroups" violates foreign key constraint "fkd_Users_id_UserGroup_UserGroups_id"')
  WHERE (SELECT id_UserGroup FROM Users WHERE id_UserGroup = OLD.id) IS NOT NULL;
END;

-- Foreign Key Preventing insert
CREATE TRIGGER fki_RolesPermissions_id_Permission_Permissions_id
BEFORE INSERT ON [RolesPermissions]
FOR EACH ROW BEGIN
  SELECT RAISE(ROLLBACK, 'insert on table "RolesPermissions" violates foreign key constraint "fki_RolesPermissions_id_Permission_Permissions_id"')
  WHERE (SELECT id FROM Permissions WHERE id = NEW.id_Permission) IS NULL;
END;

-- Foreign key preventing update
CREATE TRIGGER fku_RolesPermissions_id_Permission_Permissions_id
BEFORE UPDATE ON [RolesPermissions]
FOR EACH ROW BEGIN
    SELECT RAISE(ROLLBACK, 'update on table "RolesPermissions" violates foreign key constraint "fku_RolesPermissions_id_Permission_Permissions_id"')
      WHERE (SELECT id FROM Permissions WHERE id = NEW.id_Permission) IS NULL;
END;

-- Foreign key preventing delete
CREATE TRIGGER fkd_RolesPermissions_id_Permission_Permissions_id
BEFORE DELETE ON Permissions
FOR EACH ROW BEGIN
  SELECT RAISE(ROLLBACK, 'delete on table "Permissions" violates foreign key constraint "fkd_RolesPermissions_id_Permission_Permissions_id"')
  WHERE (SELECT id_Permission FROM RolesPermissions WHERE id_Permission = OLD.id) IS NOT NULL;
END;

-- Foreign Key Preventing insert
CREATE TRIGGER fki_RolesPermissions_id_Role_Roles_id
BEFORE INSERT ON [RolesPermissions]
FOR EACH ROW BEGIN
  SELECT RAISE(ROLLBACK, 'insert on table "RolesPermissions" violates foreign key constraint "fki_RolesPermissions_id_Role_Roles_id"')
  WHERE (SELECT id FROM Roles WHERE id = NEW.id_Role) IS NULL;
END;

-- Foreign key preventing update
CREATE TRIGGER fku_RolesPermissions_id_Role_Roles_id
BEFORE UPDATE ON [RolesPermissions]
FOR EACH ROW BEGIN
    SELECT RAISE(ROLLBACK, 'update on table "RolesPermissions" violates foreign key constraint "fku_RolesPermissions_id_Role_Roles_id"')
      WHERE (SELECT id FROM Roles WHERE id = NEW.id_Role) IS NULL;
END;

-- Foreign key preventing delete
CREATE TRIGGER fkd_RolesPermissions_id_Role_Roles_id
BEFORE DELETE ON Roles
FOR EACH ROW BEGIN
  SELECT RAISE(ROLLBACK, 'delete on table "Roles" violates foreign key constraint "fkd_RolesPermissions_id_Role_Roles_id"')
  WHERE (SELECT id_Role FROM RolesPermissions WHERE id_Role = OLD.id) IS NOT NULL;
END;

-- Foreign Key Preventing insert
CREATE TRIGGER fki_UserAuthentication_id_User_Users_id
BEFORE INSERT ON [UserAuthentication]
FOR EACH ROW BEGIN
  SELECT RAISE(ROLLBACK, 'insert on table "UserAuthentication" violates foreign key constraint "fki_UserAuthentication_id_User_Users_id"')
  WHERE (SELECT id FROM Users WHERE id = NEW.id_User) IS NULL;
END;

-- Foreign key preventing update
CREATE TRIGGER fku_UserAuthentication_id_User_Users_id
BEFORE UPDATE ON [UserAuthentication]
FOR EACH ROW BEGIN
    SELECT RAISE(ROLLBACK, 'update on table "UserAuthentication" violates foreign key constraint "fku_UserAuthentication_id_User_Users_id"')
      WHERE (SELECT id FROM Users WHERE id = NEW.id_User) IS NULL;
END;

-- Foreign key preventing delete
CREATE TRIGGER fkd_UserAuthentication_id_User_Users_id
BEFORE DELETE ON Users
FOR EACH ROW BEGIN
  SELECT RAISE(ROLLBACK, 'delete on table "Users" violates foreign key constraint "fkd_UserAuthentication_id_User_Users_id"')
  WHERE (SELECT id_User FROM UserAuthentication WHERE id_User = OLD.id) IS NOT NULL;
END;

-- Foreign Key Preventing insert
CREATE TRIGGER fki_Transactions_id_User_Users_id
BEFORE INSERT ON [Transactions]
FOR EACH ROW BEGIN
  SELECT RAISE(ROLLBACK, 'insert on table "Transactions" violates foreign key constraint "fki_Transactions_id_User_Users_id"')
  WHERE (SELECT id FROM Users WHERE id = NEW.id_User) IS NULL;
END;

-- Foreign key preventing update
CREATE TRIGGER fku_Transactions_id_User_Users_id
BEFORE UPDATE ON [Transactions]
FOR EACH ROW BEGIN
    SELECT RAISE(ROLLBACK, 'update on table "Transactions" violates foreign key constraint "fku_Transactions_id_User_Users_id"')
      WHERE (SELECT id FROM Users WHERE id = NEW.id_User) IS NULL;
END;

-- Foreign key preventing delete
CREATE TRIGGER fkd_Transactions_id_User_Users_id
BEFORE DELETE ON Users
FOR EACH ROW BEGIN
  SELECT RAISE(ROLLBACK, 'delete on table "Users" violates foreign key constraint "fkd_Transactions_id_User_Users_id"')
  WHERE (SELECT id_User FROM Transactions WHERE id_User = OLD.id) IS NOT NULL;
END;

-- Foreign Key Preventing insert
CREATE TRIGGER fki_TransChildren_id_Transaction_Transactions_id
BEFORE INSERT ON [TransChildren]
FOR EACH ROW BEGIN
  SELECT RAISE(ROLLBACK, 'insert on table "TransChildren" violates foreign key constraint "fki_TransChildren_id_Transaction_Transactions_id"')
  WHERE (SELECT id FROM Transactions WHERE id = NEW.id_Transaction) IS NULL;
END;

-- Foreign key preventing update
CREATE TRIGGER fku_TransChildren_id_Transaction_Transactions_id
BEFORE UPDATE ON [TransChildren]
FOR EACH ROW BEGIN
    SELECT RAISE(ROLLBACK, 'update on table "TransChildren" violates foreign key constraint "fku_TransChildren_id_Transaction_Transactions_id"')
      WHERE (SELECT id FROM Transactions WHERE id = NEW.id_Transaction) IS NULL;
END;

-- Foreign key preventing delete
CREATE TRIGGER fkd_TransChildren_id_Transaction_Transactions_id
BEFORE DELETE ON Transactions
FOR EACH ROW BEGIN
  SELECT RAISE(ROLLBACK, 'delete on table "Transactions" violates foreign key constraint "fkd_TransChildren_id_Transaction_Transactions_id"')
  WHERE (SELECT id_Transaction FROM TransChildren WHERE id_Transaction = OLD.id) IS NOT NULL;
END;

-- Foreign Key Preventing insert
CREATE TRIGGER fki_TransChildren_id_TransType_TransTypes_id
BEFORE INSERT ON [TransChildren]
FOR EACH ROW BEGIN
  SELECT RAISE(ROLLBACK, 'insert on table "TransChildren" violates foreign key constraint "fki_TransChildren_id_TransType_TransTypes_id"')
  WHERE (SELECT id FROM TransTypes WHERE id = NEW.id_TransType) IS NULL;
END;

-- Foreign key preventing update
CREATE TRIGGER fku_TransChildren_id_TransType_TransTypes_id
BEFORE UPDATE ON [TransChildren]
FOR EACH ROW BEGIN
    SELECT RAISE(ROLLBACK, 'update on table "TransChildren" violates foreign key constraint "fku_TransChildren_id_TransType_TransTypes_id"')
      WHERE (SELECT id FROM TransTypes WHERE id = NEW.id_TransType) IS NULL;
END;

-- Foreign key preventing delete
CREATE TRIGGER fkd_TransChildren_id_TransType_TransTypes_id
BEFORE DELETE ON TransTypes
FOR EACH ROW BEGIN
  SELECT RAISE(ROLLBACK, 'delete on table "TransTypes" violates foreign key constraint "fkd_TransChildren_id_TransType_TransTypes_id"')
  WHERE (SELECT id_TransType FROM TransChildren WHERE id_TransType = OLD.id) IS NOT NULL;
END;

-- Foreign Key Preventing insert
CREATE TRIGGER fki_TransChildren_id_Sku_Skus_id
BEFORE INSERT ON [TransChildren]
FOR EACH ROW BEGIN
  SELECT RAISE(ROLLBACK, 'insert on table "TransChildren" violates foreign key constraint "fki_TransChildren_id_Sku_Skus_id"')
  WHERE (SELECT id FROM Skus WHERE id = NEW.id_Sku) IS NULL;
END;

-- Foreign key preventing update
CREATE TRIGGER fku_TransChildren_id_Sku_Skus_id
BEFORE UPDATE ON [TransChildren]
FOR EACH ROW BEGIN
    SELECT RAISE(ROLLBACK, 'update on table "TransChildren" violates foreign key constraint "fku_TransChildren_id_Sku_Skus_id"')
      WHERE (SELECT id FROM Skus WHERE id = NEW.id_Sku) IS NULL;
END;

-- Foreign key preventing delete
CREATE TRIGGER fkd_TransChildren_id_Sku_Skus_id
BEFORE DELETE ON Skus
FOR EACH ROW BEGIN
  SELECT RAISE(ROLLBACK, 'delete on table "Skus" violates foreign key constraint "fkd_TransChildren_id_Sku_Skus_id"')
  WHERE (SELECT id_Sku FROM TransChildren WHERE id_Sku = OLD.id) IS NOT NULL;
END;

-- Foreign Key Preventing insert
CREATE TRIGGER fki_Skus_id_Item_Items_id
BEFORE INSERT ON [Skus]
FOR EACH ROW BEGIN
  SELECT RAISE(ROLLBACK, 'insert on table "Skus" violates foreign key constraint "fki_Skus_id_Item_Items_id"')
  WHERE (SELECT id FROM Items WHERE id = NEW.id_Item) IS NULL;
END;

-- Foreign key preventing update
CREATE TRIGGER fku_Skus_id_Item_Items_id
BEFORE UPDATE ON [Skus]
FOR EACH ROW BEGIN
    SELECT RAISE(ROLLBACK, 'update on table "Skus" violates foreign key constraint "fku_Skus_id_Item_Items_id"')
      WHERE (SELECT id FROM Items WHERE id = NEW.id_Item) IS NULL;
END;

-- Foreign key preventing delete
CREATE TRIGGER fkd_Skus_id_Item_Items_id
BEFORE DELETE ON Items
FOR EACH ROW BEGIN
  SELECT RAISE(ROLLBACK, 'delete on table "Items" violates foreign key constraint "fkd_Skus_id_Item_Items_id"')
  WHERE (SELECT id_Item FROM Skus WHERE id_Item = OLD.id) IS NOT NULL;
END;

-- Foreign Key Preventing insert
CREATE TRIGGER fki_Skus_id_SkuType_SkuTypes_id
BEFORE INSERT ON [Skus]
FOR EACH ROW BEGIN
  SELECT RAISE(ROLLBACK, 'insert on table "Skus" violates foreign key constraint "fki_Skus_id_SkuType_SkuTypes_id"')
  WHERE (SELECT id FROM SkuTypes WHERE id = NEW.id_SkuType) IS NULL;
END;

-- Foreign key preventing update
CREATE TRIGGER fku_Skus_id_SkuType_SkuTypes_id
BEFORE UPDATE ON [Skus]
FOR EACH ROW BEGIN
    SELECT RAISE(ROLLBACK, 'update on table "Skus" violates foreign key constraint "fku_Skus_id_SkuType_SkuTypes_id"')
      WHERE (SELECT id FROM SkuTypes WHERE id = NEW.id_SkuType) IS NULL;
END;

-- Foreign key preventing delete
CREATE TRIGGER fkd_Skus_id_SkuType_SkuTypes_id
BEFORE DELETE ON SkuTypes
FOR EACH ROW BEGIN
  SELECT RAISE(ROLLBACK, 'delete on table "SkuTypes" violates foreign key constraint "fkd_Skus_id_SkuType_SkuTypes_id"')
  WHERE (SELECT id_SkuType FROM Skus WHERE id_SkuType = OLD.id) IS NOT NULL;
END;

-- Foreign Key Preventing insert
CREATE TRIGGER fki_Skus_id_Inventory_Inventory_id
BEFORE INSERT ON [Skus]
FOR EACH ROW BEGIN
  SELECT RAISE(ROLLBACK, 'insert on table "Skus" violates foreign key constraint "fki_Skus_id_Inventory_Inventory_id"')
  WHERE (SELECT id FROM Inventory WHERE id = NEW.id_Inventory) IS NULL;
END;

-- Foreign key preventing update
CREATE TRIGGER fku_Skus_id_Inventory_Inventory_id
BEFORE UPDATE ON [Skus]
FOR EACH ROW BEGIN
    SELECT RAISE(ROLLBACK, 'update on table "Skus" violates foreign key constraint "fku_Skus_id_Inventory_Inventory_id"')
      WHERE (SELECT id FROM Inventory WHERE id = NEW.id_Inventory) IS NULL;
END;

-- Foreign key preventing delete
CREATE TRIGGER fkd_Skus_id_Inventory_Inventory_id
BEFORE DELETE ON Inventory
FOR EACH ROW BEGIN
  SELECT RAISE(ROLLBACK, 'delete on table "Inventory" violates foreign key constraint "fkd_Skus_id_Inventory_Inventory_id"')
  WHERE (SELECT id_Inventory FROM Skus WHERE id_Inventory = OLD.id) IS NOT NULL;
END;
