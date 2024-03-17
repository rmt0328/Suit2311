package restful.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "category")
@NamedQueries({
    @NamedQuery(name = "Category.findAll", query = "SELECT category FROM Category category"),
    @NamedQuery(name = "Category.findAllByNo", query = "SELECT category FROM Category category where category.categoryNo = :categoryNo")
})
public class Category extends BaseEntity{

    @Column(name = "category_no")
	private String categoryNo;
	
    @Column(name = "category_alias")
	private String categoryAlias;

	public String getCategoryNo() {
		return categoryNo;
	}

	public void setCategoryNo(String categoryNo) {
		this.categoryNo = categoryNo;
	}

	public String getCategoryAlias() {
		return categoryAlias;
	}

	public void setCategoryAlias(String categoryAlias) {
		this.categoryAlias = categoryAlias;
	}

	@Override
	public String toString() {
		return "Category{" +
				"categoryNo='" + categoryNo + '\'' +
				", categoryAlias='" + categoryAlias + '\'' +
				", id=" + id +
				", createUser=" + createUser +
				", updateUser=" + updateUser +
				", createTime=" + createTime +
				", updateTime=" + updateTime +
				'}';
	}
}
