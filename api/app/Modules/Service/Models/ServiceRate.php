<?php

namespace App\Modules\Service\Models;

use Illuminate\Database\Eloquent\Model;

class ServiceRate extends Model
{
    protected $fillable = [
        'value', 'rate_group_id', 'service_id', 'rate_unit_id'
    ];

    public function rateGroup()
    {
        return $this->belongsTo(RateGroup::class);
    }

    public function service()
    {
        return $this->belongsTo(Service::class);
    }

    public function rateUnit()
    {
        return $this->hasOne(RateUnit::class);
    }
}
