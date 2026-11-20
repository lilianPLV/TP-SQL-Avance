CREATE TABLE departements (
  dept_id  INT AUTO_INCREMENT PRIMARY KEY,
  dept_nom VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE employes_3fn (
  employe_id  INT PRIMARY KEY,
  employe_nom VARCHAR(150) NOT NULL,
  dept_id     INT NOT NULL,
  CONSTRAINT fk_emp3_dept FOREIGN KEY (dept_id) REFERENCES departements(dept_id)
) ENGINE=InnoDB;

CREATE TABLE chefs_projet (
  chef_id  INT AUTO_INCREMENT PRIMARY KEY,
  chef_nom VARCHAR(150) NOT NULL,
  chef_tel VARCHAR(20)  NOT NULL
) ENGINE=InnoDB;

CREATE TABLE projets (
  projet_id  INT AUTO_INCREMENT PRIMARY KEY,
  projet_nom VARCHAR(150) NOT NULL UNIQUE,
  chef_id    INT NOT NULL,
  CONSTRAINT fk_projet_chef FOREIGN KEY (chef_id) REFERENCES chefs_projet(chef_id)
) ENGINE=InnoDB;

CREATE TABLE affectations (
  employe_id INT NOT NULL,
  projet_id  INT NOT NULL,
  PRIMARY KEY (employe_id, projet_id),
  CONSTRAINT fk_aff_emp    FOREIGN KEY (employe_id) REFERENCES employes_3fn(employe_id),
  CONSTRAINT fk_aff_projet FOREIGN KEY (projet_id)  REFERENCES projets(projet_id)
) ENGINE=InnoDB;