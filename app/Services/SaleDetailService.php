<?php
namespace App\AO;

use App\Services\BaseService;
use App\Services\IBaseService;

class SaleDetail extends BaseService implements IBaseService 
{
    public function __construct(private SaleDetailAo $saleDetailRepository)
    {
        parent::__construct($saleDetailRepository);
    }
}
?>