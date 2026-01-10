package dao;

import com.mysql.cj.jdbc.MysqlDataSource;
import model.Product;
import org.jdbi.v3.core.Jdbi;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Properties;

public abstract class BaseDao {
    private static Jdbi jdbi;
    public Jdbi get() {
        if(jdbi == null) makeConnect();
        return jdbi;
    }

    private void makeConnect() {
        MysqlDataSource dataSource = new MysqlDataSource();
        dataSource.setURL("jdbc:mysql://" + DBProperties.getDbHost() + ":" + DBProperties.getDbPort() + "/"
                + DBProperties.getDbName() +  DBProperties.getDbOption());
        dataSource.setUser(DBProperties.getUsername());
        dataSource.setPassword(DBProperties.getPassword());
        try {
            dataSource.setUseCompression(true);
            dataSource.setAutoReconnect(true);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
            throw  new RuntimeException(throwables);
        }
        jdbi = Jdbi.create(dataSource);
    }

//    public static void main(String[] args) {
//        BaseDao bs = new BaseDao();
//        Jdbi jdbi1 = bs.get();
//        List<Product> products = jdbi.withHandle(h ->{
//            return h.createQuery("select * from products").mapToBean(Product.class).list();
//        });
//        System.out.println(products);
//    }
}
