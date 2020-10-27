contract update{
    struct contractaddress{
        uint256 version;
        address saddress;
    }
    enum contractstate{
        usable,
        disable
    }
    enum state{
        call,
        falsecall
    }
    struct contractinfo{
        string name;
        address conaddress;
        uint states;
    }
    contractstate private csstate=contractstate.usable;
    mapping(address=>uint) maptocstate;
    mapping(string=>contractaddress[]) nametocontract;
    mapping(string=>address) versiontoadd;
    mapping(address=>contractinfo[])callrelatioship;
    address[] addarray;
    event recordcallevent(string name,address conaddress);
    function registered(string memory _cname,address _saddress)public{
        uint256 versionnum=1;
        nametocontract[_cname].push(contractaddress({version:versionnum,saddress:_saddress}));
    }
    function setupdate(string memory _cname,address _saddress) public{
        uint256 versionnum;
        versionnum=nametocontract[_cname].length+1;
        nametocontract[_cname].push(contractaddress({version:versionnum,saddress:_saddress}));
    }
    function getcurrentversionadd(string memory _cname)public view returns(address){
        return(nametocontract[_cname][nametocontract[_cname].length-1].saddress);
    }
    function setstate(address add)public {
        maptocstate[add]=uint(csstate);
    }
    function disablestate(address add)public{
        maptocstate[add]=uint(contractstate.disable);
    }
    function checkstate(address add)public view returns(bool){
        if(uint(maptocstate[add])==0){
            return true;
        }else if(uint(maptocstate[add])==1){
            return false;
        }else{
            return false;
        }
    }
    function recordcall(string memory _name1,string memory _name2) public{
        address add1;
        address add2;
        add1=getcurrentversionadd(_name1);
        add2=getcurrentversionadd(_name2);
        callrelatioship[add1].push(contractinfo({name:_name2,conaddress:add2,states:uint(state.call)}));
    }
    function getcall(address _add) public returns(address[] memory a){
        // if(callrelatioship[_add].length==0){
        //     return ;
        // }else{
        for(uint i=0;i<=callrelatioship[_add].length;i++){
            emit recordcallevent(callrelatioship[_add][i].name,callrelatioship[_add][i].conaddress);
            addarray.push(callrelatioship[_add][i].conaddress);
        }
        return addarray;
        //}
    }
    function updatecall(string memory _name1,string memory _name2,string memory _name3) public{
        address add1;
        add1=getcurrentversionadd(_name1);
        // for(uint i=0;i<callrelatioship[add1].length;i++){
        //     if(callrelatioship[add1][i].name==_name2){
        //         callrelatioship[add1][i].states=uint(state.falsecall);
        //         recordcall(_name1,_name2);
        //     }
        // }

    }
}
