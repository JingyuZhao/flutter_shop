const serviceUrl =
    'https://wxmini.baixingliangfan.cn/baixing/'; //此端口针对于正版用户开放，可自行fiddle获取。
const home_page_content = 'homePageContent';
const home_page_tip = 'getHomePageTip';
const home_page_below_conten = 'homePageBelowConten';

const category_page_content = 'getCategory';
const category_page_small_category = 'getMallGoods';

const goods_goods_detail = 'getGoodsInfo';

const servicePath = {
  home_page_content: serviceUrl + 'wxmini/homePageContent', // 商家首页信息
  home_page_tip: serviceUrl + 'wxmini/getHomePageTip', //首页弹窗信息
  home_page_below_conten:
      serviceUrl + 'wxmini/homePageBelowConten', //商城首页热卖商品拉取
  category_page_content: serviceUrl + 'wxmini/getCategory', //分类页面
  category_page_small_category: serviceUrl + 'wxmini/getMallGoods', //商品分类的商品列表
  goods_goods_detail: serviceUrl + 'wxmini/getGoodDetailById', //商品详情
};
