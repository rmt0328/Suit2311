package restful.entity;

/**
 * @author YeXingyi
 * @version 1.0
 * @date 2023/11/26 11:52
 */
public class RegisterUser extends User{
    private String passwordAgain;

    public String getPasswordAgain() {
        return passwordAgain;
    }

    public void setPasswordAgain(String passwordAgain) {
        this.passwordAgain = passwordAgain;
    }

    @Override
    public String toString() {
        return super.toString()+"RegisterUser{"+
                "passwordAgain='" + passwordAgain + '\'' +
                ", id=" + id +
                ", createUser=" + createUser +
                ", updateUser=" + updateUser +
                ", createTime=" + createTime +
                ", updateTime=" + updateTime +
                '}';
    }
}
