-- Tabla de Usuarios
CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY DEFAULT auth.uid(),
  email TEXT UNIQUE NOT NULL,
  full_name TEXT,
  phone TEXT,
  avatar_url TEXT,
  created_at TIMESTAMP DEFAULT now(),
  updated_at TIMESTAMP DEFAULT now()
);

-- Tabla de Cuentas Bancarias
CREATE TABLE IF NOT EXISTS cuentas (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  numero_cuenta TEXT UNIQUE NOT NULL,
  tipo_cuenta TEXT NOT NULL,
  saldo DECIMAL(15, 2) DEFAULT 0,
  moneda TEXT DEFAULT 'USD',
  estado TEXT DEFAULT 'activa',
  fecha_apertura TIMESTAMP DEFAULT now(),
  created_at TIMESTAMP DEFAULT now(),
  updated_at TIMESTAMP DEFAULT now()
);

-- Tabla de Tarjetas
CREATE TABLE IF NOT EXISTS tarjetas (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  numero_tarjeta TEXT UNIQUE NOT NULL,
  tipo_tarjeta TEXT NOT NULL,
  titular TEXT NOT NULL,
  fecha_vencimiento TEXT NOT NULL,
  cvv TEXT NOT NULL,
  saldo DECIMAL(15, 2) DEFAULT 0,
  limite_credito DECIMAL(15, 2),
  estado TEXT DEFAULT 'activa',
  created_at TIMESTAMP DEFAULT now(),
  updated_at TIMESTAMP DEFAULT now()
);

-- Tabla de Préstamos
CREATE TABLE IF NOT EXISTS prestamos (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  numero_prestamo TEXT UNIQUE NOT NULL,
  monto_original DECIMAL(15, 2) NOT NULL,
  saldo_pendiente DECIMAL(15, 2) NOT NULL,
  tasa_interes DECIMAL(5, 2) NOT NULL,
  plazo_meses INTEGER NOT NULL,
  fecha_inicio TIMESTAMP NOT NULL,
  fecha_vencimiento TIMESTAMP NOT NULL,
  estado TEXT DEFAULT 'activo',
  created_at TIMESTAMP DEFAULT now(),
  updated_at TIMESTAMP DEFAULT now()
);

-- Tabla de Movimientos/Transacciones
CREATE TABLE IF NOT EXISTS movimientos (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  cuenta_id UUID REFERENCES cuentas(id) ON DELETE CASCADE,
  tipo_movimiento TEXT NOT NULL,
  monto DECIMAL(15, 2) NOT NULL,
  descripcion TEXT,
  fecha TIMESTAMP DEFAULT now(),
  saldo_anterior DECIMAL(15, 2),
  saldo_posterior DECIMAL(15, 2),
  created_at TIMESTAMP DEFAULT now()
);

-- Índices para mejorar rendimiento
CREATE INDEX idx_cuentas_user_id ON cuentas(user_id);
CREATE INDEX idx_tarjetas_user_id ON tarjetas(user_id);
CREATE INDEX idx_prestamos_user_id ON prestamos(user_id);
CREATE INDEX idx_movimientos_user_id ON movimientos(user_id);
CREATE INDEX idx_movimientos_cuenta_id ON movimientos(cuenta_id);
CREATE INDEX idx_movimientos_fecha ON movimientos(fecha);

-- Habilitar Row Level Security (RLS)
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE cuentas ENABLE ROW LEVEL SECURITY;
ALTER TABLE tarjetas ENABLE ROW LEVEL SECURITY;
ALTER TABLE prestamos ENABLE ROW LEVEL SECURITY;
ALTER TABLE movimientos ENABLE ROW LEVEL SECURITY;

-- Políticas RLS para usuarios autenticados (cada usuario ve solo sus datos)
CREATE POLICY "Users can view own data" ON users
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can view own cuentas" ON cuentas
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can view own tarjetas" ON tarjetas
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can view own prestamos" ON prestamos
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can view own movimientos" ON movimientos
  FOR SELECT USING (auth.uid() = user_id);

-- Permitir inserciones por usuarios autenticados
CREATE POLICY "Users can insert cuentas" ON cuentas
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can insert tarjetas" ON tarjetas
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can insert prestamos" ON prestamos
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can insert movimientos" ON movimientos
  FOR INSERT WITH CHECK (auth.uid() = user_id);
