<?php

namespace App\Modules\Service\Models;

use Illuminate\Database\Eloquent\Model;

class ServiceRate extends Model
{
    protected $fillable = [
        'name', 'description'
    ];

    public function rateGroup(){
        $this->belongsTo(RateGroup::class);
    }

    public function service(){
        $this->belongsTo(Service::class);
    }

    public function rateUnit(){
        $this->hasOne(RateUnit::class);
    }
}
