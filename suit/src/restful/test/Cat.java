package restful.test;

import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

import restful.entity.IdEntity;

@Entity
@Table(name = "T_Cat")
@NamedQueries({
    @NamedQuery(name = "Cat.findAll", query = "SELECT cat FROM Cat cat"),
    @NamedQuery(name = "Cat.findAllByName", query = "SELECT cat FROM Cat cat where cat.name like :name")
})
public class Cat extends IdEntity{
	
	private String code;
	
	private String name;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
