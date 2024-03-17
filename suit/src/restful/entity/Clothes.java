package restful.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import java.math.BigDecimal;

@Entity
@Table(name = "clothes")
@NamedQueries({
    @NamedQuery(name = "Clothes.findAll", query = "SELECT clothes FROM Clothes clothes"),
    @NamedQuery(name = "Clothes.findAllByNo", query = "SELECT clothes FROM Clothes clothes where clothes.clothesNo = :clothesNo"),
		@NamedQuery(
				name = "Clothes.findClothesBySAC",
				query = "SELECT clothes FROM Clothes clothes WHERE clothes.sex = :sex AND clothes.categoryId = :id"
		)
})
public class Clothes extends BaseEntity{
	
    @Column(name = "clothes_no")
	private String clothesNo;
	
    @Column(name = "clothes_alias")
	private String clothesAlias;
	
	private Double price;
	
	private Integer sex;
	
    @Column(name = "category_id")

	private Long categoryId;
	
	private String img;

	public String getClothesNo() {
		return clothesNo;
	}

	public void setClothesNo(String clothesNo) {
		this.clothesNo = clothesNo;
	}

	public String getClothesAlias() {
		return clothesAlias;
	}

	public void setClothesAlias(String clothesAlias) {
		this.clothesAlias = clothesAlias;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public Long getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Long categoryId) {
		this.categoryId = categoryId;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}


	@Override
	public String toString() {
		return "Clothes{" +
				"clothesNo='" + clothesNo + '\'' +
				", clothesAlias='" + clothesAlias + '\'' +
				", price=" + price +
				", sex=" + sex +
				", categoryId=" + categoryId +
				", img='" + img + '\'' +
				", id=" + id +
				", createUser=" + createUser +
				", updateUser=" + updateUser +
				", createTime=" + createTime +
				", updateTime=" + updateTime +
				'}';
	}
}
