Create database concecionaria ;
use concecionaria;

create table tb_veiculo(
placa char(7) primary key,
modelo varchar(256),
marca varchar(45),
fabricante varchar(45),
cor varchar(45),
ano date,
categoria varchar(45),
vl_compra decimal(10,2),
vl_venda decimal(10,2),
chassis char(17)
);

create table tb_seguro(
cd_seguro int primary key auto_increment,
vl_seguro decimal(10,2),
fk_placa char(7),
foreign key (fk_placa) references tb_veiculo (placa)
);

DELIMITER $$
CREATE TRIGGER tr_seguro_insert
AFTER INSERT ON tb_veiculo
FOR EACH ROW
begin
    INSERT INTO tb_seguro (vl_seguro, fk_placa)
    VALUES (NEW.vl_venda * 1.1273, NEW.placa);
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER tr_seguro_delete
AFTER DELETE ON tb_veiculo
FOR EACH ROW
BEGIN
    DELETE FROM tb_seguro
    WHERE fk_placa = OLD.placa;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER tr_seguro_update
AFTER UPDATE ON tb_veiculo
FOR EACH ROW
BEGIN
    UPDATE tb_seguro
    SET vl_seguro = NEW.vl_venda * 1.1273
    WHERE fk_placa = NEW.placa;
END$$
DELIMITER ;

insert into tb_veiculo values
('fid7r53', 'Mercedes Benz cla 200', 'Mercedes Benz', 'Mercedes Benz', 'Preto', '2016-03-03', 'Sedan', 87000.00, 95000.00 , '2FZ60Unjzb0rc2214' ),
('wie0c39', 'Fiat Toro', 'Fiat', 'Fiat','Vermelho', '2026-02-08', 'Pickup', 183000.00, 195000.00 , '6ucaeRhbusg3X5806'),
('sje2d30', 'Chevrolet Camaro SS', 'Chevrolet', 'Chevrolet', 'Amarelo', '2018-12-12', 'Muscle Car', 350000.00, 397000.00, '384LcWK5NgRR52873'),
('ali6d69', 'Chevrolet Onix', 'Chevrolet', 'Chevrolet', 'Branco', '2020-10-11', 'Hatch', 70000.00, 81000.00, '3cXlyXZZmYV3j3636');

select * from tb_seguro;