package restful.entity;


import javax.persistence.*;

@Entity
@Table(name = "clothes_details")
@NamedQueries({
		@NamedQuery(name = "ClothesDetails.findAll", query = "SELECT clothesDetails FROM ClothesDetails clothesDetails"),
		@NamedQuery(name = "ClothesDetails.findAllByUserId", query = "SELECT clothesDetails FROM ClothesDetails clothesDetails where clothesDetails.userId = :userId"),
		@NamedQuery(name = "ClothesDetails.findAllByClothesId", query = "SELECT clothesDetails FROM ClothesDetails clothesDetails where clothesDetails.clothesId = :clothesId")
})
public class ClothesDetails extends BaseEntity{
	@Column(name = "user_id")
	private Long userId;

	@Column(name = "clothes_id")
	private Long clothesId;

	private Integer priority;

	@Column(name = "category_id")
	private Long categoryId;

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Long getClothesId() {
		return clothesId;
	}

	public void setClothesId(Long clothesId) {
		this.clothesId = clothesId;
	}

	public Integer getPriority() {
		return priority;
	}

	public void setPriority(Integer priority) {
		this.priority = priority;
	}

	public Long getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Long categoryId) {
		this.categoryId = categoryId;
	}

	@Override
	public String toString() {
		return "ClothesDetails{" +
				"userId=" + userId +
				", clothesId=" + clothesId +
				", priority=" + priority +
				", categoryId=" + categoryId +
				", id=" + id +
				", createUser=" + createUser +
				", updateUser=" + updateUser +
				", createTime=" + createTime +
				", updateTime=" + updateTime +
				'}';
	}
}
