enum EnemyState {
	Normal,
	Dead,
	Attacking,
	GottenHit,
	OnTheGround,
	JuggleState
}

event_inherited();
hpInitial = 5;
hp = 5;
weak = false;
isEnemy=true;