package restful.api;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;

import restful.bean.Result;
import restful.database.EM;
import restful.entity.Category;
import restful.entity.Clothes;
import restful.entity.RegisterUser;
import restful.entity.User;

@Path("/clothes")
public class ClothesAPI {
	@Context
	private HttpServletRequest request;

	//增加服饰
	@POST
	@Path("/addClothes")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result addClothes(Clothes clothes) {
//		完整性判断
//		if(clothes.getCategoryNo()==null||category.getCategoryAlias()==null) {
//			return new Result(0,"分类信息不为空","","");
//		}

		List<Clothes> result = EM.getEntityManager()
				.createNamedQuery("Clothes.findAllByNo", Clothes.class)
				.setParameter("clothesNo", clothes.getClothesNo()).getResultList();
		if (result.size() != 0) {
			return new Result(0, "该服饰已存在", "", "");
		}

		clothes.setCreateTime(new Date());
		clothes.setCreateUser(((User) (request.getSession().getAttribute("user"))).getId());
		clothes.setUpdateTime(new Date());
		clothes.setUpdateUser(((User) (request.getSession().getAttribute("user"))).getId());

		EM.getEntityManager().merge(clothes);
		EM.getEntityManager().getTransaction().commit();

		return new Result(0, "添加服饰成功", clothes, "");
	}


	//删除服饰

	@POST
	@Path("/deleteClothes")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result deleteClothes(Clothes clothes) {

		EM.getEntityManager().remove(EM.getEntityManager().merge(clothes));
		EM.getEntityManager().getTransaction().commit();

		return new Result(0, "删除分类成功", clothes, "");
	}


//	修改服饰

	@POST
	@Path("/updateClothes")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result updateCurUser(Clothes clothes) {
		if (clothes.getClothesNo() == null || clothes.getClothesAlias() == null || clothes.getSex() == null || clothes.getCategoryId() == null || clothes.getImg() == null) {
			return new Result(0, "数据不合法", " ", "");
		}
		//user.setUsername(Ruser.getUsername());


		//先判断修改后的No是否重复
		List<Clothes> result = EM.getEntityManager()
				.createNamedQuery("Clothes.findAllByNo", Clothes.class)
				.setParameter("clothesNo", clothes.getClothesNo()).getResultList();
		if (result.size() != 0&& !result.get(0).getId().equals(clothes.getId())) {
			return new Result(-1, "该服饰已存在", "", "");
		}


		clothes.setUpdateTime(new Date());
		clothes.setUpdateUser(((User) request.getSession().getAttribute("user")).getId());

		clothes = EM.getEntityManager().merge(clothes);

		EM.getEntityManager().getTransaction().commit();
		System.out.print(clothes.toString());
		return new Result(0, "修改成功", clothes, "");

	}


	//通过性别和服饰所属分类查服饰

	@POST
	@Path("/findClothesBySAC")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result findClothesBySAC(Clothes clothes) {
		Integer sex = clothes.getSex();
		Long id = clothes.getCategoryId();

		System.out.println("sex:"+sex+"   id:"+id);

		List<Clothes> result = EM.getEntityManager()
				.createNamedQuery("Clothes.findClothesBySAC", Clothes.class)
				.setParameter("sex", sex)
				.setParameter("id", id)
				.getResultList();

		System.out.println(result.toString());

		return new Result(0, "获取分类列表信息成功", result, "");
	}

	@POST
	@Path("/getAll")
	@Produces("application/json;charset=UTF-8")
	public Result getAll() {
		List<Clothes> result = EM.getEntityManager()
				.createNamedQuery("Clothes.findAll", Clothes.class)
				.getResultList();

		return new Result(0, "获取服饰列表信息成功", result, "");
	}

}
