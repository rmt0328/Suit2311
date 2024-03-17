package restful.entity;


import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;


/**
 * @author YeXingyi
 * @version 1.0
 * @date 2023/11/26 10:48
 */
@MappedSuperclass
public class BaseEntity implements Serializable {
    /** 描述  */
    private static final long serialVersionUID = 8430941165882152228L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    protected Long id = 0L;
   
   
	@Column(name = "create_user")
    protected Long createUser;
    
    @Column(name = "update_user")
    protected Long updateUser;
    
    @Column(name = "create_time")
    protected Date createTime=new Date();
    
    @Column(name = "update_time")
    protected Date updateTime=new Date();

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }


    public Long getCreateUser() {
        return createUser;
    }

    public void setCreateUser(Long createUser) {
        this.createUser = createUser;
    }

    public Long getUpdateUser() {
        return updateUser;
    }

    public void setUpdateUser(Long updateUser) {
        this.updateUser = updateUser;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
}
