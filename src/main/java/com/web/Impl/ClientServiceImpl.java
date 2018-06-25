package com.web.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.dao.ClientDao;
import com.web.pojo.ClientBean;
import com.web.service.ClientService;

@Service
public class ClientServiceImpl implements ClientService{

	@Autowired
	private ClientDao clientdao;
	
	@Override
	public int insertClient(ClientBean client) {
		// TODO Auto-generated method stub
		return this.clientdao.insertClient(client);
	}

	@Override
	public int deleteClient(Integer id) {
		// TODO Auto-generated method stub
		return this.clientdao.deleteClient(id);
	}

	@Override
	public ClientBean getClientByid(Integer id) {
		// TODO Auto-generated method stub
		return this.clientdao.getClientByid(id);
	}

	@Override
	public List<ClientBean> getAllClient(Integer user_id) {
		// TODO Auto-generated method stub
		return this.clientdao.getAllClient(user_id);
	}

	@Override
	public int updateClientStatus(ClientBean client) {
		// TODO Auto-generated method stub
		return this.clientdao.updateClientStatus(client);
	}

	@Override
	public int updateClientInfo(ClientBean client) {
		// TODO Auto-generated method stub
		return this.clientdao.updateClientInfo(client);
	}

	@Override
	public ClientBean getClientByClientid(String Client_id) {
		// TODO Auto-generated method stub
		return this.clientdao.getClientByClientid(Client_id);
	}
	
}
