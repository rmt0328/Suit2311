package restful.api;

import javax.ws.rs.POST;
import javax.ws.rs.Path;

@Path("/test")
public class TestAPI {
	@POST
	@Path("/a")
	public String test() {
		return "测试接口";
	}
}
